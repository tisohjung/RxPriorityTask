//
//  VCTaskList.swift
//  RxPriorityTask
//
//  Created by minho on 2021/05/21.
//

import UIKit

class VCTaskList: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

}

// MARK: - UITableViewDataSource
extension VCTaskList : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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

