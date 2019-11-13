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
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    
    private func goToFirstState() {
        if withComputer {
            // игра с компьютером - поочередно, первый - первый игрок (человек)
            self.currentState = GetPlayerInputState(player: Player.first)
        } else {
            // игра двух игроков - сразу все ходы, первый - первый игрок
            self.currentState = GetPlayerBatchState(player: Player.first)
        }
    }

    private func goToNextState() {
        // проверка окончания игры и выявления победителя
        let result = self.referee.isGameOver()
        if result.0 {
            self.currentState = GameEndedState(winner: result.1, gameViewController: self)
            return
        } else if (currentState as? BatchExecuteState) != nil {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
        if withComputer {
            if let state = currentState as? PlayerInputState {
                self.currentState = GetComputerInputState(player: state.player.next) // ход компьютерв
                goToNextState() // сразу переход дальше
            } else if let state = currentState as? ComputerInputState {
                self.currentState = GetPlayerInputState(player: state.player.next) // ход человека
            }
        } else {
            if let state = currentState as? PlayerBatchState {
                if (state.player == Player.first) {
                    self.currentState = GetPlayerBatchState(player: state.player.next)
                } else {
                    self.currentState = BatchExecuteState(referee: referee)
                    goToNextState()
                }
            }
        }
    }
    
    private func GetPlayerInputState(player: Player) -> PlayerInputState {
        return PlayerInputState(player: player,
                                markViewPrototype: player.markViewPrototype,
                                gameViewController: self,
                                gameboard: gameboard,
                                gameboardView: gameboardView)
    }
    
    private func GetComputerInputState(player: Player) -> ComputerInputState {
        return ComputerInputState(player: player,
                                markViewPrototype: player.markViewPrototype,
                                gameViewController: self,
                                gameboard: gameboard,
                                gameboardView: gameboardView)
    }
    
    private func GetPlayerBatchState(player: Player) -> PlayerBatchState {
        return PlayerBatchState(player: player,
                                markViewPrototype: player.markViewPrototype,
                                gameViewController: self,
                                gameboard: gameboard,
                                gameboardView: gameboardView)
    }

    @IBAction func restartButtonTapped(_ sender: UIButton) {
        //Log(.restartGame)
        gameboard.clear()
        gameboardView.clear()
        self.goToFirstState()
    }
}

