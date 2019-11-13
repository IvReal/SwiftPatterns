//
//  GameCommand.swift
//  XO-game
//
//  Created by Iv on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class GameCommand {
    
    let player: Player
    let position: GameboardPosition
    let board: Gameboard?
    let view: GameboardView?
    
    init(player: Player, position: GameboardPosition, board: Gameboard?, view: GameboardView?) {
        self.player = player
        self.position = position
        self.board = board
        self.view = view
    }
    
    func execute() {
        self.board?.setPlayer(self.player, at: position)
        self.view?.removeMarkView(at: position)
        self.view?.placeMarkView(self.player.markViewPrototype, at: position)
    }
}
