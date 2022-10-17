//
//  Task.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import Foundation
class Task: Codable {
    var taskName: String
    var isComplete: Bool
    let id: UUID
    
    init(taskName: String, isComplete: Bool = false, id: UUID = UUID()) {
        self.taskName = taskName
        self.isComplete = isComplete
        self.id = id
    }
    
} // End of Class

/// Extending class to adopt and conform to equatable protocol for cell entries to compare themselves to other entries in order to index and delete
extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
