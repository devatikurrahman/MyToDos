//
//  ToDoListViewModel.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import Foundation
import Combine

final class DataStore: ObservableObject {
    @Published var toDoList:[ToDo] = []
    @Published var appError: ErrorType? = nil
    
    var addToDo = PassthroughSubject<ToDo, Never>()
    var updateToDo = PassthroughSubject<ToDo, Never>()
    var deleteToDo = PassthroughSubject<IndexSet, Never>()
    var loadToDo = Just(FileManager.docDirURL.appendingPathComponent(fileName))
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirURL.path)
        addSubscriptions()
        /*
         if FileManager().docExist(name: fileName) {
            loadToDo()
         }
         */
    }
    
    func addSubscriptions() {
        loadToDo
            .filter { FileManager.default.fileExists(atPath: $0.path) }
            .tryMap { url in
                try Data(contentsOf: url)
            }
            .decode(type: [ToDo].self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("Loading Completed")
                    toDosSubscription()
                case .failure(let error):
                    if error is ToDoError {
                        appError = ErrorType(error: error as! ToDoError)
                    } else {
                        appError = ErrorType(error: ToDoError.decodingError)
                        toDosSubscription()
                    }
                }
            } receiveValue: { (toDos) in
                self.toDoList = toDos
            }
            .store(in: &subscriptions)
        
        
        updateToDo.sink { [unowned self] toDo in
            guard let index = toDoList.firstIndex(where: { $0.id == toDo.id}) else { return }
            toDoList[index] = toDo
            //saveToDos()
        }
        .store(in: &subscriptions)
        
        deleteToDo.sink { [unowned self] indexSet in
            toDoList.remove(atOffsets: indexSet)
            //saveToDos()
        }
        .store(in: &subscriptions)
    }
    
    
    func toDosSubscription() {
        $toDoList
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .encode(encoder: JSONEncoder())
            .tryMap { data in
                try data.write(to: FileManager.docDirURL.appendingPathComponent(fileName))
            }
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("Saving Completed")
                case .failure(let error):
                    if error is ToDoError {
                        appError = ErrorType(error: error as! ToDoError)
                    } else {
                        appError = ErrorType(error: ToDoError.encodingError)
                    }
                }
            } receiveValue: { _ in
                print("Saving file was successful")
            }
            .store(in: &subscriptions)

        
        
        addToDo.sink { [unowned self] toDo in
            toDoList.append(toDo)
            //saveToDos()
        }
        .store(in: &subscriptions)
    }
    
    
    /*
    func addToDo(_ toDo: ToDo) {
        toDoList.append(toDo)
        saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDoList.firstIndex(where: { $0.id == toDo.id}) else { return }
        toDoList[index] = toDo
        saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDoList.remove(atOffsets: indexSet)
    }
     */
    
    /*
    func loadToDo() {
        //toDoList = ToDo.sampleData
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    toDoList = try decoder.decode([ToDo].self, from: data)
                } catch {
                    //print(ToDoError.decodingError.localizedDescription)
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
                //print(error.localizedDescription)
                appError = ErrorType(error: error)
            }
            
        }
    }
    */
    
    /*
    func saveToDos() {
        print("Saving toDos data")
        let encode = JSONEncoder()
        do {
            let data = try encode.encode(toDoList)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    //print(error.localizedDescription)
                    appError = ErrorType(error: error)
                }
            }
        } catch {
            //print(ToDoError.encodingError.localizedDescription)
            appError = ErrorType(error: .encodingError)
        }
    }
     */
}
