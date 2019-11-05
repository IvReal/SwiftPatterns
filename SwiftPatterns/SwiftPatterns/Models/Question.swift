//
//  Question.swift
//  SwiftPatterns
//
//  Created by Iv on 17.10.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

struct Question: Codable {
    let question: String
    var answers = [String]()
    let rightAnswer: Int
    init(question: String, answers: [String], rightAnswer: Int) {
        self.question = question
        self.answers.append(contentsOf: answers)
        self.rightAnswer = rightAnswer
    }
}
