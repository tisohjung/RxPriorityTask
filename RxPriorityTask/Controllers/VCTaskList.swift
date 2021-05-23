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
    private var filteredTasks = [Task]()

    let disposeBag = DisposeBag()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let addTaskVC = navC.viewControllers.first as? VCAddTask else {
            fatalError("Controller not found")
        }
        addTaskVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
                var existingTasks = self.tasks.value
                existingTasks.append(task)
                self.tasks.accept(existingTasks)

                self.filterTask(by: priority)
            }).disposed(by: disposeBag)
    }

    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }

    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map({ tasks in
                return tasks.filter({ $0.priority == priority! })
            }).subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                print(tasks)
            }).disposed(by: disposeBag )
        }
    }

    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension VCTaskList : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VCTaskList", for: indexPath)
        cell.textLabel?.text = filteredTasks[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension VCTaskList : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}

