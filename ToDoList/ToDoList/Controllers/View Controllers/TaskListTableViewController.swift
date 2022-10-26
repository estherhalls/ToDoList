//
//  TaskListTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit
protocol TaskListTableViewControllerDelegate: AnyObject {
    
}

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
    
    func presentNewDeviceAlertController() {
        
        let alertController = UIAlertController(title: "All Tasks Complete!", message: "Delete from To-Do list?", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Cancel", style: .destructive)
        let confirmAction = UIAlertAction(title: "Delete", style: .default) { _ in
            DispatchQueue.main.async {
                guard let toDo = self.toDoReceiver else {return}
                self.toDoController.deleteToDo(toDoToDelete: toDo)
                /// Navigate back to ToDo TableView when To Do item is deleted
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(dismissAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    
    // MARK: - Helper Functions
    /// Reset text field to clear after create button is tapped
    func resetTextField() {
        taskNameTextField.text = ""
    }
    
    // MARK: - Actions
    /// Task can only be added this way when arriving at detail view from table view cell. I tried adding segue from ToDo title creation text field to detail VC, which worked but would not allow tasks to be added until I left and came back in. Will require additional "is this new or updated" functionality to model controller and add task button. I will return to this later.
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
