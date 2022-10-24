//
//  ToDo.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import Foundation
class ToDo: Codable {
    var toDoName: String
    var toDoTasks: [Task]
    var isComplete: Bool
    let id: UUID
    
    init(toDoName: String, toDoTasks: [Task] = [], isComplete: Bool = false, id: UUID = UUID()) {
        self.toDoName = toDoName
        self.toDoTasks = toDoTasks
        self.isComplete = isComplete
        self.id = id
    }
    
} // End of Class

/// Extending class to adopt and conform to equatable protocol for cell entries to compare themselves to other entries in order to index and delete
extension ToDo: Equatable {
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}
