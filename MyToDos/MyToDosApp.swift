//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI
import TipKit

@main
struct MyToDosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
                .onAppear {
                    DebugFIles.print(URL.documentsDirectory.path(), type: .info, extended: true)
                }
        }
    }
    init() {
        try? Tips.configure()
    }
}
