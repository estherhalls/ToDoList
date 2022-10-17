//
//  TaskListTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    // Receiver:
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
    
    
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "All Done!", message: "Want us to delete this list?", preferredStyle: .alert)
    }
    let dismissAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
    alertController.addAction(dismissAction)
    let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
        self.ToDoController.sharedInstance.delete(toDoToDelete: <#T##ToDo#>)
        // is this where I need delegate? YES
        //        self.ToDoController.sharedInstance.delete(toDoToDelete: ToDo)
        /// Navigate back to ToDo TableView when To Do item is deleted
    }
    navigationController?.popViewController(animated: true)
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
