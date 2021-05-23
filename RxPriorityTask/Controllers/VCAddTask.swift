//
//  VCAddTask.swift
//  RxPriorityTask
//
//  Created by minho on 2021/05/23.
//

import UIKit

class VCAddTask: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!

    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else {
            return
        }

        let task = Task(title: title, priority: priority)
    }
}
