//
//  AddQuestionViewController.swift
//  SwiftPatterns
//
//  Created by Iv on 05.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var tvQuestion: UITextView!
    @IBOutlet weak var tfAnswer1: UITextField!
    @IBOutlet weak var tfAnswer2: UITextField!
    @IBOutlet weak var tfAnswer3: UITextField!
    @IBOutlet weak var tfAnswer4: UITextField!
    @IBOutlet weak var scRightAnswer: UISegmentedControl!
    
    @IBAction func addQuestionAction(_ sender: Any) {
        let question = Question(question: tvQuestion.text, answers: [tfAnswer1.text ?? "Ответ 1", tfAnswer2.text ?? "Answer 2", tfAnswer3.text ?? "Answer 3", tfAnswer4.text ?? "Answer 4"], rightAnswer: scRightAnswer.selectedSegmentIndex + 1)
        Game.shared.addUserQuestion(question)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tap gesture -> hideKeyboard action
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(hideKeyboardGesture)
        tvQuestion.becomeFirstResponder()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
