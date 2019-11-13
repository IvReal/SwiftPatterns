//
//  GameInvoker.swift
//  XO-game
//
//  Created by Iv on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

internal final class GameInvoker {
    
    // MARK: Singleton
    
    internal static let shared = GameInvoker()
    
    // MARK: Private properties
    
    private var commands: [GameCommand] = []
    
    // MARK: Internal
    
    internal func addGameCommand(_ command: GameCommand) -> Bool {
        let result = checkCommand(command)
        if result {
            self.commands.append(command)
        }
        return result
    }
    
    internal func executeCommands() {
        var commands1: [GameCommand] = []
        var commands2: [GameCommand] = []
        for c in commands {
            if c.player == Player.first {
                commands1.append(c)
            } else {
                commands2.append(c)
            }
        }
        var mixed_commands: [GameCommand] = []
        for i in 0..<max(commands1.count, commands2.count) {
            if i < commands1.count { mixed_commands.append(commands1[i]) }
            if i < commands2.count { mixed_commands.append(commands2[i]) }
        }
        mixed_commands.forEach { $0.execute() }
        self.commands = []
    }
    
    /*internal func isComplete() -> Bool {
        return self.commands.count > GameboardSize.columns * GameboardSize.rows
    }*/
    
    // проверяем не пытается ли один и тот же игрок поставить еще раз свою отметку в ту же позицию
    internal func checkCommand(_ command: GameCommand) -> Bool {
        for c in commands {
            if c.player == command.player &&
                c.position.column == command.position.column &&
                c.position.row == command.position.row {
                return false
            }
        }
        return true
    }
}
