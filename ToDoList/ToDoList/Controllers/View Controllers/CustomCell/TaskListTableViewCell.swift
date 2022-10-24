//
//  TaskListTableViewCell.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

// Protocol Declaration for toggling task checked button:
protocol TaskListTableViewCellDelegate: AnyObject {
    func toggleTaskCompleteButtonTapped(cell: TaskListTableViewCell)
}

class TaskListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskCompleteButton: UIButton!
    
    /// I need an intern - optional because we don't need it now, but want the job listing available.
    /// delegate is weak var and weak is always optional
    weak var delegate: TaskListTableViewCellDelegate?
    
   // Helper Functions:
    func configure(with task: Task) {
        taskNameLabel.text = task.taskName
        
        let imageName = task.isComplete ? "checkmark.square.fill" : "checkmark.square"
        let completeCheckmark = UIImage(systemName: imageName)
        taskCompleteButton.setImage(completeCheckmark, for: .normal)
    }
    
// MARK: - Actions
    
    @IBAction func taskCompleteButtonTapped(_ sender: Any) {
        delegate?.toggleTaskCompleteButtonTapped(cell: self)
    }
}
