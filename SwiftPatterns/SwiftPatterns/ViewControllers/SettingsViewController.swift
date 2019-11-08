//
//  SettingsViewController.swift
//  SwiftPatterns
//
//  Created by Iv on 05.11.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var scQuestionStrategy: UISegmentedControl!
    
    @IBAction func questionChoiceStrategyChanged(_ sender: Any) {
        Game.shared.questionStrategy = QuestionStrategy(rawValue: scQuestionStrategy.selectedSegmentIndex) ?? QuestionStrategy.Sequential
    }
    
    @IBAction func clearUserQuestions(_ sender: Any) {
        Game.shared.clearUserQuestions()
    }
    
    @IBAction func clearResults(_ sender: Any) {
        Game.shared.clearResults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let index = Game.shared.questionStrategy.rawValue
        scQuestionStrategy.selectedSegmentIndex = index < 0 || index > scQuestionStrategy.numberOfSegments - 1 ? 0 : index
    }
}
