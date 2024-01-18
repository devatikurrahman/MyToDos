//
//  ToDoListViewModel.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import Foundation

final class DataStore: ObservableObject {
    @Published var toDoList:[ToDo] = []
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(name: fileName) {
            loadToDo()
        }
    }
    
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
    
    func loadToDo() {
        //toDoList = ToDo.sampleData
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    toDoList = try decoder.decode([ToDo].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
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
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
