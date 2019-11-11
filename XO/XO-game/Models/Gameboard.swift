//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
    
    // MARK: - Properties
    
    private lazy var positions: [[Player?]] = initialPositions()
    
    // MARK: - public
    
    public func setPlayer(_ player: Player, at position: GameboardPosition) {
        positions[position.column][position.row] = player
    }
    
    public func clear() {
        self.positions = initialPositions()
    }
    
    public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
        for position in positions {
            guard contains(player: player, at: position) else {
                return false
            }
        }
        return true
    }
    
    public func contains(player: Player, at position: GameboardPosition) -> Bool {
        let (column, row) = (position.column, position.row)
        return positions[column][row] == player
    }
    
    public func isFull() -> Bool {
        for position in positions {
            for player in position {
                if (player == nil) {
                    return false
                }
            }
        }
        return true
    }
    
    public func getRandomFreePosition() -> GameboardPosition? {
        var freePositions: [GameboardPosition] = []
        for col in 0..<GameboardSize.columns {
            for row in 0..<GameboardSize.rows {
                if positions[col][row] == nil {
                    freePositions.append(GameboardPosition(column: col, row: row))
                }
            }
        }
        if freePositions.count > 0 {
            let randomIndex = Int.random(in: 0..<freePositions.count)
            return freePositions[randomIndex]
        }
        return nil
    }
    
    // MARK: - Private
    
    private func initialPositions() -> [[Player?]] {
        var positions: [[Player?]] = []
        for _ in 0 ..< GameboardSize.columns {
            let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
            positions.append(rows)
        }
        return positions
    }
}
