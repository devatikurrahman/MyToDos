//
//  ToDo.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var completed: Bool = false
    
    static var sampleData: [ToDo] {
        [
            ToDo(name: "Get Lunches"),
            ToDo(name: "Meeting at afternoon"),
            ToDo(name: "Dinner with family friends")
        ]
    }
}
