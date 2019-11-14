//
//  TaskCaretaker.swift
//  TasksApp
//
//  Created by Iv on 14.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

final class TaskCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "tasks"
    
    func save(task: MyTask) {
        do {
            let data = try self.encoder.encode(task)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func restore() -> MyTask? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try self.decoder.decode(MyTask.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
