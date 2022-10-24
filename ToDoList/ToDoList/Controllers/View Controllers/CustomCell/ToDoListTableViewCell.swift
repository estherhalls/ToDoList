//
//  ToDoListTableViewCell.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import UIKit

/// A delegate protocol for the ToDoListTableViewCell which signals when the cell's complete button value is changed
protocol ToDoListTableViewCellDelegate: AnyObject {
    /// A delegate method signalling when checkmark value is changed in cell
    func isCompleteButtonTapped(_ cell: ToDoListTableViewCell)
}

class ToDoListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var toDoIsCompleteButton: UIButton!
    @IBOutlet weak var toDoNameLabel: UILabel!
    @IBOutlet weak var toDoTaskCountLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: ToDoListTableViewCellDelegate?
    
    // MARK: - Methods
    /// Updates the table view cell's view elements for the given ToDo cell content
    func configureCell (toDo: ToDo) {
        toDoNameLabel.text = toDo.toDoName
        toDoTaskCountLabel.text = "\(toDo.toDoTasks.count)"
        
        let imageName = toDo.isComplete ? "checkmark.diamond.fill" : "checkmark.diamond"
        let taskCompleteImage = UIImage(systemName: imageName)
        toDoIsCompleteButton.setImage(taskCompleteImage, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func toDoIsCompleteButtonValueChanged(_ sender: UIButton) {
        delegate?.isCompleteButtonTapped(self)
    }
    
    
}
