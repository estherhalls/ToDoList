//
//  TaskController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import Foundation
class TaskController {
    
    // MARK: - CRUD
    static func create(name: String, in toDo: ToDo){
        let task = Task(taskName: name)
        toDo.toDoTasks.append(task)
        ToDoController.sharedInstance.save()
    }
    
    static func update(updateTask: Task, updateName: String) {
        updateTask.taskName = updateName
        ToDoController.sharedInstance.save()
    }
    
    static func delete(deleteTask: Task, from toDo: ToDo) {
        guard let index = toDo.toDoTasks.firstIndex(of: deleteTask)
        else { return }
        toDo.toDoTasks.remove(at: index)
        ToDoController.sharedInstance.save()
    }
    
    
} // End of Class
