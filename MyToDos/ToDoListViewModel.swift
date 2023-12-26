//
//  ToDoListViewModel.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import Foundation

final class ToDoListViewModel: ObservableObject {
    @Published var toDoList:[ToDo] = []
    
    init() {
        loadToDo()
    }
    
    func addToDo(_ toDo: ToDo) {
        
    }
    
    func updateToDo(_ toDo: ToDo) {
        
    }
    
    func deleteToDo(at indexSet: ToDo) {
        
    }
    
    func loadToDo() {
        toDoList = ToDo.sampleData
    }
    
    func saveToDos() {
        print("Saving toDos data")
    }
}
