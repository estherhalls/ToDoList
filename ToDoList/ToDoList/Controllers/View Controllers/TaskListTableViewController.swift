//
//  TaskListTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit
//protocol TaskListTableViewControllerDelegate: AnyObject {
//    let deleteToDoRow =
//}

class TaskListTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    
    let toDoController = ToDoController.sharedInstance
    
    // Receiver (of type, not assignment operator):
    var toDoReceiver: ToDo?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // unwrap optional with nil coallescing
        return toDoReceiver?.toDoTasks.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskListTableViewCell,
              let toDoReceiver = toDoReceiver else {
            return UITableViewCell()}
        let task = toDoReceiver.toDoTasks[indexPath.row]
        cell.configure(with: task)
        cell.delegate = self
        
        return cell
    }
    
    /// This method is called when user swipes to delete a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let toDoReceiver = toDoReceiver else { return }
            let task = toDoReceiver.toDoTasks[indexPath.row]
            toDoController.deleteTask(deleteTask: task, from: toDoReceiver)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//    private func presentNewDeviceAlertController() {
//        let alertController = UIAlertController(title: "All Done!", message: "Delete from to do list?", preferredStyle: .alert)
//    let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//    alertController.addAction(dismissAction)
//        
//    let confirmAction = UIAlertAction(title: "Delete", style: .default) { _ in
//        DispatchQueue.main.async {
//            let toDo = toDoController.toDoList[indexPath.row]
//            ToDoController.sharedInstance.delete(toDoToDelete: toDo)
//        }
//    }
//        /// Navigate back to ToDo TableView when To Do item is deleted
//        navigationController?.popViewController(animated: true)
//    }
    
    // MARK: - Helper Functions
    /// Reset text field to clear after create button is tapped
    func resetTextField() {
        taskNameTextField.text = ""
    }
     
     // MARK: - Actions
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        /// is there text to save?
        guard let taskName = taskNameTextField.text,
              let toDo = toDoReceiver
        else {return}
        toDoController.createTask(name: taskName, in: toDo)
        resetTextField()
        tableView.reloadData()
    }
}
extension TaskListTableViewController: TaskListTableViewCellDelegate {
    func toggleTaskCompleteButtonTapped(cell: TaskListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
        let toDoReceiver = toDoReceiver else {return}
        let selectedTask = toDoReceiver.toDoTasks[indexPath.row]
        toDoController.toggleTaskComplete(for: selectedTask)
        cell.configure(with: selectedTask)
    }
}
