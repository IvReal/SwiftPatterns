//
//  PlayerBatchState.swift
//  XO-game
//
//  Created by Iv on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class PlayerBatchState: GameState {
    
    public private(set) var isCompleted = false
    public private(set) var counter = 5
    
    public let player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    public let markViewPrototype: MarkView

    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }

    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position)
            else { return }
        if GameInvoker.shared.addGameCommand(GameCommand(player: self.player, position: position, board: self.gameboard, view: self.gameboardView)) {
            counter -= 1
            Log(.playerInput(player: player, position: position))
        }
        if counter == 0 {
            self.isCompleted = true
        }
    }
    
}
