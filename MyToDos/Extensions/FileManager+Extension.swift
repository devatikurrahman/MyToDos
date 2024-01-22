//
//  FileManager+Extension.swift
//  MyToDos
//
//  Created by Atikur Rahman on 1/19/24.
//

import Foundation
import OSLog

extension FileManager {
    static let fileName = "ToDos.json"
    static let logger = Logger.fileManager
    
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveDocument(contents: String, docName: String, completion: (ToDoError?) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            Self.logger.error("\(error.localizedDescription)")
            completion(.saveError)
        }
    }
    
    func readDocument(docName: String, completion: (Result<Data, ToDoError>) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            Self.logger.error("\(error.localizedDescription)")
            completion(.failure(.readError))
        }
    }
    
    func docExist(name docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
}
