//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
  
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    private lazy var referee = Referee(gameboard: self.gameboard)
    public var withComputer = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        
        firstPlayerTurnLabel.text = withComputer ? "player" : "1st player"
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        /*self.currentState = PlayerInputState(player: .first,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)*/
        let player = Player.first
        self.currentState = PlayerInputState(player: player,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        if (gameboard.isFull()) {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
        if withComputer {
            if let state = currentState as? PlayerInputState {
                let player = state.player.next
                self.currentState = ComputerInputState(player: player,
                                                       markViewPrototype: player.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
                goToNextState()
            } else if let state = currentState as? ComputerInputState {
                let player = state.player.next
                self.currentState = PlayerInputState(player: player,
                                                     markViewPrototype: player.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
            }
        } else {
            if let playerInputState = currentState as? PlayerInputState {
                /*self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)*/
                let player = playerInputState.player.next
                self.currentState = PlayerInputState(player: player,
                                                     markViewPrototype: player.markViewPrototype,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
            }
        }
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        gameboard.clear()
        gameboardView.clear()
        self.goToFirstState()
    }
}

