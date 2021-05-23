//
//  VCAddTask.swift
//  RxPriorityTask
//
//  Created by minho on 2021/05/23.
//

import UIKit
import RxSwift

class VCAddTask: UIViewController {
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!

    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text else {
            return
        }

        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)

        self.dismiss(animated: true, completion: nil)
    }
}
