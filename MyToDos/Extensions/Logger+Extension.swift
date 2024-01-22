//
//  Logger+Extension.swift
//  MyToDos
//
//  Created by Atikur Rahman on 1/23/24.
//

import Foundation
import OSLog

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let myToDosApp = Logger(subsystem: subsystem, category: "MyToDosApp")
    static let dataStore = Logger(subsystem: subsystem, category: "DataStore")
    static let fileManager = Logger(subsystem: subsystem, category: "FileManager")
}
