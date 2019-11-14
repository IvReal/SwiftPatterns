//
//  BatchExecuteState.swift
//  XO-game
//
//  Created by Iv on 12.11.2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class BatchExecuteState: GameState {
    public private(set) var isCompleted = false

    private(set) weak var referee: Referee?

    init(referee: Referee) {
        self.referee = referee
    }

    public func begin() {
        //GameInvoker.shared.executeCommands()
        GameInvoker.shared.executeEachCommand(checkIsWinner: checkIsWinner)
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func checkIsWinner() -> Bool {
        return referee?.determineWinner() != nil
    }
}
