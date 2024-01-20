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
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirURL.path)
        addSubscriptions()
        if FileManager().docExist(name: fileName) {
            loadToDo()
        }
    }
    
    func addSubscriptions() {
        addToDo.sink { [unowned self] toDo in
            toDoList.append(toDo)
            saveToDos()
        }
        .store(in: &subscriptions)
        
        updateToDo.sink { [unowned self] toDo in
            guard let index = toDoList.firstIndex(where: { $0.id == toDo.id}) else { return }
            toDoList[index] = toDo
            saveToDos()
        }
        .store(in: &subscriptions)
        
        deleteToDo.sink { [unowned self] indexSet in
            toDoList.remove(atOffsets: indexSet)
            saveToDos()
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
}
