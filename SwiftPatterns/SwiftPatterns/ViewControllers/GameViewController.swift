//
//  GameViewController.swift
//  SwiftPatterns
//
//  Created by Iv on 16.10.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var currentSession: GameSession?
    weak var delegateEndGame: GameViewControllerDelegate?

    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBAction func buttonTap(_ sender: Any) {
        let button = sender as! UIButton
        guard let title = button.title(for: UIControl.State.normal) else { return }
        // create the alert
        let alert = UIAlertController(title: labelQuestion.text, message: "\(title)", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Да", style: UIAlertAction.Style.default, handler: {action in
            self.DoCheckAnswer(answerNumber: button.tag)
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        
        currentSession = GameSession(questions: Game.shared.questions)
        currentSession?.currentStep.addObserver(self, options: [.new, .initial], closure: { [weak self] (curStep, _) in
            guard let session = self?.currentSession else { return }
            self?.labelHeader.text = "Вопрос \(curStep) из \(session.questionCount), правильных \(session.resultInPercent)%"
        })
        Game.shared.startNewGameSession(session: currentSession!)
        
        DoNextStep()
    }
    
    func DoNextStep() {
        guard let question = currentSession?.nextStep() else {
            self.gameOver(withResult: 1)
            return
        }
        labelQuestion.text = question.question
        button1.setTitle(question.answers[0], for: UIControl.State.normal)
        button2.setTitle(question.answers[1], for: UIControl.State.normal)
        button3.setTitle(question.answers[2], for: UIControl.State.normal)
        button4.setTitle(question.answers[3], for: UIControl.State.normal)
    }
    
    func DoCheckAnswer(answerNumber: Int) {
        guard let session = currentSession else { return }
        let IsRight = session.checkCurrentAnswer(answerNumber: answerNumber)
        if (IsRight) {
            DoNextStep()
        } else {
            //showMessage(msg: "Ответ неверный")
            self.gameOver(withResult: 0)
        }
    }
    
    func gameOver(withResult result: Int) {
        self.delegateEndGame?.didEndGame(withResult: result)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*func showMessage(msg: String) {
        let alert = UIAlertController(title: "Ответ", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }*/
}

protocol GameViewControllerDelegate: class {
    func didEndGame(withResult result: Int)
}
