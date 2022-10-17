//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var toDoNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Tableview to scale cell height to its content
        tableView.rowHeight = UITableView.automaticDimension
        /// estimated height to start calculating from
        tableView.estimatedRowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// When ToDo table view displays after task view alert confirms deleted To Do item
        tableView.reloadData()
    }

    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoController.sharedInstance.toDoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
        let toDo = ToDoController.sharedInstance.toDoList[indexPath.row]
        cell.configureCell(with: toDo)
        /// how to relay information of number of tasks within the toDo item to the detail text?
//        cell.detailTextLabel?.text = "\(TaskController.sharedInstance.tasks.count)"
        return cell
    }
    
    /// This method is called when user swipes to delete a row
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if editingStyle == .delete {
            let toDo = ToDoController.sharedInstance.toDoList[indexPath.row]
            ToDoController.sharedInstance.delete(toDoToDelete: toDo)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Helper Functions
    /// Reset text field to clear after create button is tapped
    func resetTextField() {
        toDoNameTextField.text = ""
    }
    // MARK: - Actions
    
    @IBAction func createButtonTapped(_ sender: Any) {
        /// is there text to save?
        guard let toDoName = toDoNameTextField.text
        else {return}
        ToDoController.sharedInstance.createToDo()
        resetTextField()
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTVC" {
            if let index = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? TaskListTableViewController {
                    let toDoToSend = ToDoController.sharedInstance.toDoList[index.row]
                    destination.toDoReceiver = toDoToSend
                }
            }
        }
 
    }
 

}
