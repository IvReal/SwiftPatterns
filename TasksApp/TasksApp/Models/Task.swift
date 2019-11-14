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

class MyTask: Task, Codable {
    
    var name: String
    var subtasks: [Task] = []
    var count: Int {
        return subtasks.count
    }

    init(name: String) {
        self.name = name
    }
    
    func add(task: Task) {
        if let mytask = task as? MyTask {
            subtasks.append(mytask)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case subtasks
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        subtasks = try container.decode([MyTask].self, forKey: .subtasks)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var mysubtasks: [MyTask] = []
        for task in subtasks {
            if let mytask = task as? MyTask {
                mysubtasks.append(mytask)
            }
        }
        try container.encode(mysubtasks, forKey: .subtasks)
    }

}

var root: Task = MyTask(name: "My Tasks")
