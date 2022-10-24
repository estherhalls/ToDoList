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
    
    // MARK: - Properties
    let toDoController = ToDoController.sharedInstance
    var toDo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Tableview to scale cell height to its content
        tableView.rowHeight = UITableView.automaticDimension
        /// estimated height to start calculating from
        tableView.estimatedRowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /// When ToDo table view displays after task view alert confirms deleted To Do item
        resetTextField()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoController.toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoListTableViewCell else { return UITableViewCell() }
        let toDo = toDoController.toDoList[indexPath.row]
        cell.configureCell(toDo: toDo)
        /// each cell will have its own intern - cell by cell basis
        cell.delegate = self
        
        return cell
    }
    
    /// This method is called when user swipes to delete a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDo = toDoController.toDoList[indexPath.row]
            toDoController.deleteToDo(toDoToDelete: toDo)
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
        toDoController.createToDo(name: toDoName)
        resetTextField()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTVC" {
            if let index = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? TaskListTableViewController {
                    let toDoToSend = toDoController.toDoList[index.row]
                    destination.toDoReceiver = toDoToSend
                }
            }
        }
    }
}

extension ToDoTableViewController: ToDoListTableViewCellDelegate {
    func isCompleteButtonTapped(_ cell: ToDoListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let toDo = toDoController.toDoList[indexPath.row]
        toDoController.toggleToDoComplete(for: toDo)
        cell.configureCell(toDo: toDo)
    }
}
