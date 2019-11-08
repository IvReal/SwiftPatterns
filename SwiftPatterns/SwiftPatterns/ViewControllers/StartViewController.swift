//
//  StartViewController.swift
//  SwiftPatterns
//
//  Created by Iv on 21.10.2019.
//  Copyright © 2019 Iv. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var buttonResult: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "segueStartGameSession":
                guard let destination = segue.destination as? GameViewController else { return }
                destination.delegateEndGame = self
            default:
                break
        }
    }
    
    @IBAction func settingsUnwindAction(​unwindSegue​: UIStoryboardSegue) {
        
    }
    
    @IBAction func addQuestionUnwindAction(​unwindSegue​: UIStoryboardSegue) {
        
    }
}

extension StartViewController: GameViewControllerDelegate {
    func didEndGame(withResult result: Int) {
        guard let session = Game.shared.gameSession else { return }
        self.buttonResult.setTitle("Правильно \(session.resultInPercent)%", for: UIControl.State.normal)
        Game.shared.endSession()
    }
}
