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
        }
    }
    init() {
        try? Tips.configure()
    }
}
