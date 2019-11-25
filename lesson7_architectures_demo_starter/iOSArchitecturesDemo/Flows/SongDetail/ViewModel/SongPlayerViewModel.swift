//
//  SongPlayerViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 25.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation
import Combine

final class SongPlayerViewModel {
    
    var timer: Timer!
    var isPlaying = false

    @Published var currentPercent = 0
    
    func start() {
        startTimer()
        isPlaying = true
    }
    
    func stop() {
        stopTimer()
        currentPercent = 0
        isPlaying = false
    }
    
    func pause() {
        stopTimer()
        isPlaying = false
    }
    
    func startTimer() {

        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        }
    }

    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }

    @objc func loop() {
        self.currentPercent += 1
        if self.currentPercent >= 100 {
            stop()
        }
    }
    
    deinit {
        timer.invalidate()
    }

}
