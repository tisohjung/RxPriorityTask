//
//  Task.swift
//  RxPriorityTask
//
//  Created by minho on 2021/05/23.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}
struct Task {
    let title: String
    let priority: Priority
}
