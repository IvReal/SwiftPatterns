//
//  QuestionChoiceStrategy.swift
//  SwiftPatterns
//
//  Created by Iv on 05.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

enum QuestionStrategy: Int { case Sequential = 0, Random  }

protocol QuestionChoiceStrategy: class {
    var questions: [Question]? { get set }
    func getNextQuestion() -> Question?
}

class SequentialQuestionStrategy: QuestionChoiceStrategy {
    var questions: [Question]? {
        didSet {
            lastQuestionIndex = -1
        }
    }
    private var lastQuestionIndex: Int = -1
    func getNextQuestion() -> Question? {
        guard let q = questions else { return nil }
        lastQuestionIndex += 1
        return lastQuestionIndex < q.count ? q[lastQuestionIndex] : nil
    }
}

class RandomQuestionStrategy: QuestionChoiceStrategy {
    var questions: [Question]? {
        didSet {
            indexes = []
            guard let q = questions else { return }
            for i in 0...q.count - 1 {
                indexes.append(i)
            }
        }
    }
    private var indexes: [Int] = []
    func getNextQuestion() -> Question? {
        guard let q = questions, indexes.count > 0 else { return nil }
        indexes.shuffle()
        let resIndex = indexes[0]
        indexes.remove(at: 0)
        return q[resIndex]
    }
}
