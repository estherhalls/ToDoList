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
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        let toDo = ToDoController.sharedInstance.toDoList[indexPath.row]
        cell.textLabel?.text = toDo.toDoName
        cell.detailTextLabel?.text = "\(TaskController.sharedInstance.tasks.count)"

        // Configure the cell...

        return cell
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
