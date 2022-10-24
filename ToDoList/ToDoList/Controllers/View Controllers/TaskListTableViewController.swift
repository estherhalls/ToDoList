//
//  TaskListTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    
    // Receiver (of type, not assignment operator):
    var toDoReceiver: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        // Configure the cell...
        
        return cell
    }
    
    /// This method is called when user swipes to delete a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let toDoReceiver = toDoReceiver else { return }
            let task = toDoReceiver.toDoTasks[indexPath.row]
            TaskController.delete(deleteTask: task, from: toDoReceiver)
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
//            toDoReceiver.tableView.deleteRows(at: [IndexPath], with: .fade)
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
        TaskController.create(name: taskName, in: toDo)
        resetTextField()
        tableView.reloadData()
    }
 
}
