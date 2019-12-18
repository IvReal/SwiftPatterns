//
//  AppDetailWhatsNewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 20.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewViewController: UIViewController {

    // MARK: - Properties
    
    private let app: ITunesApp
    
    private var appDetailWhatsNewView: AppDetailWhatsNewView {
        return self.view as! AppDetailWhatsNewView
    }
    
    // MARK: - Init
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailWhatsNewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }
    
    // MARK: - Private
    
    private func fillData() {
        self.appDetailWhatsNewView.titleLabel.text = "Что нового"
        self.appDetailWhatsNewView.versionLabel.text = "Версия \(app.version ?? "")"
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        self.appDetailWhatsNewView.dateLabel.text = "Дата \(formatter.string(from: app.releaseDate!))"
        self.appDetailWhatsNewView.descriptionLabel.text = app.releaseNotes
    }

}
