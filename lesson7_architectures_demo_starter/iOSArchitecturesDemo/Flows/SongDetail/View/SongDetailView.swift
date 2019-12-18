//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 25.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class SongDetailView: UIView {
    
    // MARK: - Subviews
    
    let labelTrack = UILabel()
    let labelArtist = UILabel()
    let buttonPlay = UIButton(type: .system)
    let buttonStop = UIButton(type: .system)
    let buttonPause = UIButton(type: .system)
    let progress = UIProgressView(progressViewStyle: .default)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Configure
    
    public func configure(track: String, artist: String) {
        self.labelTrack.text = track
        self.labelArtist.text = artist
    }
    
    public func setProgress(percent: Int) {
        self.progress.progress = Float(percent) / Float(100)
    }

    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addTrackLabel()
        self.addArtistLabel()
        self.addPlayButton()
        self.addStopButton()
        self.addPauseButton()
        self.addProgress()
    }
    
    private func addTrackLabel() {
        self.labelTrack.translatesAutoresizingMaskIntoConstraints = false
        self.labelTrack.textColor = .black
        self.labelTrack.font = UIFont.systemFont(ofSize: 18.0)
        self.addSubview(self.labelTrack)
        NSLayoutConstraint.activate([
            self.labelTrack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.labelTrack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
            self.labelTrack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            ])
    }
    
    private func addArtistLabel() {
        self.labelArtist.translatesAutoresizingMaskIntoConstraints = false
        self.labelArtist.textColor = .lightGray
        self.labelArtist.font = UIFont.systemFont(ofSize: 16.0)
        self.addSubview(self.labelArtist)
        NSLayoutConstraint.activate([
            self.labelArtist.topAnchor.constraint(equalTo: self.labelTrack.bottomAnchor, constant: 8.0),
            self.labelArtist.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
            self.labelArtist.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            ])
    }
    
    private func addPlayButton() {
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.setTitle("Пуск", for: .normal)
        buttonPlay.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        buttonPlay.layer.cornerRadius = 16.0
        self.addSubview(self.buttonPlay)
        NSLayoutConstraint.activate([
            self.buttonPlay.topAnchor.constraint(equalTo: self.labelArtist.bottomAnchor, constant: 16.0),
            self.buttonPlay.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
            self.buttonPlay.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    private func addStopButton() {
        buttonStop.translatesAutoresizingMaskIntoConstraints = false
        buttonStop.setTitle("Стоп", for: .normal)
        buttonStop.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        buttonStop.layer.cornerRadius = 16.0
        self.addSubview(self.buttonStop)
        NSLayoutConstraint.activate([
            self.buttonStop.topAnchor.constraint(equalTo: self.labelArtist.bottomAnchor, constant: 16.0),
            self.buttonStop.leftAnchor.constraint(equalTo: self.buttonPlay.rightAnchor, constant: 5.0),
            self.buttonStop.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    private func addPauseButton() {
        buttonPause.translatesAutoresizingMaskIntoConstraints = false
        buttonPause.setTitle("Пауза", for: .normal)
        buttonPause.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        buttonPause.layer.cornerRadius = 16.0
        self.addSubview(self.buttonPause)
        NSLayoutConstraint.activate([
            self.buttonPause.topAnchor.constraint(equalTo: self.labelArtist.bottomAnchor, constant: 16.0),
            self.buttonPause.leftAnchor.constraint(equalTo: self.buttonStop.rightAnchor, constant: 5.0),
            self.buttonPause.widthAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    private func addProgress() {
        progress.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(progress)
        NSLayoutConstraint.activate([
            self.progress.topAnchor.constraint(equalTo: self.buttonPause.bottomAnchor, constant: 16.0),
            self.progress.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0),
            self.progress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0)
            ])
    }
}
