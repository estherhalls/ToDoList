//
//  TaskListTableViewController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "All Done!", message: "Want us to delete this list?", preferredStyle: .alert)
    }
    let dismissAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
    alertController.addAction(dismissAction)
    let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
        self.ModelController.deleteToDo()
        /// Navigate back to ToDo TableView when To Do item is deleted
        navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
