//
//  GameState.swift
//  XO-game
//
//  Created by Iv on 11.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public protocol GameState {
    var isCompleted: Bool { get }
    func begin()
    func addMark(at position: GameboardPosition)
}

