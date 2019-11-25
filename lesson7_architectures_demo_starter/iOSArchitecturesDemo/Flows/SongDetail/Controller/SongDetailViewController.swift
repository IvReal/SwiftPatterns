//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 25.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit
import Combine

final class SongDetailViewController: UIViewController {

    public var song: ITunesSong?
    public var viewModel: SongPlayerViewModel?
    private var sink = Set<AnyCancellable>()

    private var songDetailView: SongDetailView {
        return self.view as! SongDetailView
    }
 
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SongDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationController()
        self.configureUI()
        viewModel = SongPlayerViewModel()
        bindViewModel()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureUI() {
        self.songDetailView.configure(track: self.song?.trackName ?? "", artist: self.song?.artistName ?? "")
        self.songDetailView.buttonPlay.addTarget(self, action: #selector(self.Play), for: .touchUpInside)
        self.songDetailView.buttonStop.addTarget(self, action: #selector(self.Stop), for: .touchUpInside)
        self.songDetailView.buttonPause.addTarget(self, action: #selector(self.Pause), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel?.$currentPercent.sink { [unowned self] percent in
            self.songDetailView.setProgress(percent: percent)
        }.store(in: &sink)
    }

    @objc func Play(sender: UIButton!)
    {
        self.viewModel?.start()
    }
    
    @objc func Stop(sender: UIButton!)
    {
        self.viewModel?.stop()
    }
    
    @objc func Pause(sender: UIButton!)
    {
        self.viewModel?.pause()
    }
}
