//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI
import TipKit
import OSLog

@main
struct MyToDosApp: App {
    //let logger = Logger(subsystem: "com.mycompany.MyToDos", category: "MyToDosApp")
    @State private var dataStore = DataStore()
    
    var body: some Scene {
        let logger = Logger.myToDosApp
        WindowGroup {
            ToDoListView()
                .environment(dataStore)
                .onAppear {
                    //DebugFIles.print(URL.documentsDirectory.path(), type: .info, extended: true)
                    logger.info("\(URL.documentsDirectory.path())")
                }
        }
    }
    init() {
        try? Tips.configure()
    }
}
