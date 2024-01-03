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
        loadToDo()
    }
    
    func addToDo(_ toDo: ToDo) {
        toDoList.append(toDo)
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDoList.firstIndex(where: { $0.id == toDo.id}) else { return }
        toDoList[index] = toDo
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDoList.remove(atOffsets: indexSet)
    }
    
    func loadToDo() {
        toDoList = ToDo.sampleData
    }
    
    func saveToDos() {
        print("Saving toDos data")
    }
}
