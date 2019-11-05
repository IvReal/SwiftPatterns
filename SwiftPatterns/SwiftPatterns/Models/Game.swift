//
//  Game.swift
//  SwiftPatterns
//
//  Created by Iv on 17.10.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import Foundation

class Game {
    static let shared = Game()
    private init() {
        self.results = self.resCaretaker.restore()
        self.reloadQuestions()
    }
    
    var questionStrategy: QuestionStrategy = QuestionStrategy.Sequential
    var gameSession: GameSession?
    var results: [GameResult]
    var questions: [Question] = []

    private let resCaretaker = ResultsCaretaker()
    private let questionCaretaker = UserQuestionCaretaker()

    func reloadQuestions() {
        questions = []
        // basic set
        var a: [String] = ["коллекцию", "коррупцию", "конструкцию", "информацию"]
        var q = Question(question: "Что не собирают?", answers: a, rightAnswer: 2)
        questions.append(q)
        a = ["совковая", "граблевая", "тяпковая", "мотыжная"]
        q = Question(question: "Какая бывает лопата?", answers: a, rightAnswer: 1)
        questions.append(q)
        a = ["\"Варяг\"", "\"Кореец\"", "\"Викинг\"", "\"Чухонец\""]
        q = Question(question: "Как называется фильм, снятый по мотивам \"Повести временных лет\"?", answers: a, rightAnswer: 3)
        questions.append(q)
        a = ["на пальцы", "на уши", "на волосы", "на зубы"]
        q = Question(question: "На что надевают брекеты?", answers: a, rightAnswer: 4)
        questions.append(q)
        a = ["дельфин", "медведь", "попугай", "крокодил"]
        q = Question(question: "Кто такой ара?", answers: a, rightAnswer: 3)
        questions.append(q)
        // user set
        let userQuestions = self.questionCaretaker.restore()
        if userQuestions.count > 0 {
            for q in userQuestions {
                questions.append(q)
            }
        }
        print("Questions:\n\(questions)")
    }
    
    func startNewGameSession(session: GameSession) {
        self.gameSession = session
    }
    
    func endSession() {
        guard let session = gameSession else { return }
        let result = GameResult(date: Date(), percent: session.resultInPercent)
        results.append(result)
        self.resCaretaker.save(results: results)
        gameSession = nil
    }
    
    func addUserQuestion(_ question: Question) {
        var userQuestions = questionCaretaker.restore()
        userQuestions.append(question)
        questionCaretaker.save(questions: userQuestions)
        reloadQuestions()
    }
    
    func clearUserQuestions() {
        questionCaretaker.clear()
        reloadQuestions()
    }
    
    func clearResults() {
        resCaretaker.clear()
    }
}

class GameSession {
    private let questions: [Question]
    private(set) var currentStep = Observable<Int>(0)
    private var currentQuestion: Question?
    var questionCount: Int { return questions.count }
    var rightAnswersCount: Int = 0
    var resultInPercent: Int
    {
        return rightAnswersCount * 100 / questionCount
    }
    private var questionChoiceStrategy: QuestionChoiceStrategy

    init(questions: [Question]) {
        self.questions = questions
        if (Game.shared.questionStrategy == QuestionStrategy.Random) {
            self.questionChoiceStrategy = RandomQuestionStrategy()
        } else {
            self.questionChoiceStrategy = SequentialQuestionStrategy()
        }
        self.questionChoiceStrategy.questions = questions
    }
    
    func nextStep() -> Question? {
        currentQuestion = self.questionChoiceStrategy.getNextQuestion()
        if (currentQuestion != nil) { currentStep.value += 1  }
        return currentQuestion
    }
    
    func checkCurrentAnswer(answerNumber: Int) -> Bool {
        guard let curQuestion = currentQuestion else { return false }
        let res = curQuestion.rightAnswer == answerNumber
        if (res) { rightAnswersCount += 1 }
        return res
    }
}

struct GameResult: Codable {
    let date: Date
    let percent: Int
}
