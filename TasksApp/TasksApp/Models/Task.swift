//
//  Task.swift
//  TasksApp
//
//  Created by Iv on 13.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

protocol Task {
    var name: String { get }
    var count: Int { get }
    var subtasks: [Task] { get }
    func add(task: Task)
}

class MyTask: Task {
    
    var name: String
    var subtasks: [Task] = []
    var count: Int {
        return subtasks.count
    }

    init(name: String) {
        self.name = name
    }
    
    func add(task: Task) {
        subtasks.append(task)
    }
}

let root: Task = MyTask(name: "My Tasks")
