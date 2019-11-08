//
//  Caretaker.swift
//  SwiftPatterns
//
//  Created by Iv on 05.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

final class ResultsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "results"
    
    func save(results: [GameResult]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func restore() -> [GameResult] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([GameResult].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

final class UserQuestionCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "questions"
    
    func save(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func restore() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
