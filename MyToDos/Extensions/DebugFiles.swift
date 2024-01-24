//
//  DebugFIles.swift
//  MyToDos
//
//  Created by Atikur Rahman on 1/22/24.
//

import Foundation

public enum DebugFiles: String {
    case info = "🍎"
    case error = "❌"
    
    public static func print(_ items: Any ...,
                             type: DebugFiles,
                             extended: Bool = false,
                             fileID: String = #fileID,
                             function: String = #function,
                             line: Int = #line) {
        Swift.print(type.rawValue, items.map{ "\($0)" }.joined(separator: " "))
        if extended {
            Swift.print(
                """
                    fileID: \(fileID)
                    function: \(function)
                    line:" \(line)
                    ---------------------------
                """
            )
        }
    }
}
