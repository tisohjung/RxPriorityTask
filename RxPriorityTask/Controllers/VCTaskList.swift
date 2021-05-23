//
//  VCTaskList.swift
//  RxPriorityTask
//
//  Created by minho on 2021/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class VCTaskList: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var tasks = BehaviorRelay<[Task]>(value: [])

    let disposeBag = DisposeBag()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTaskVC = navC.viewControllers.first as? VCAddTask else {
            fatalError("Controller not found")
        }
        addTaskVC.taskSubjectObservable
            .subscribe(onNext: { task in
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension VCTaskList : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VCTaskList", for: indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension VCTaskList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}

