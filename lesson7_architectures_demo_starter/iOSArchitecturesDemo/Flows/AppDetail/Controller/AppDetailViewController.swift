//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    let app: ITunesApp
    
    lazy var headerViewController = AppDetailHeaderViewController(app: self.app)
    lazy var whatsnewViewController = AppDetailWhatsNewViewController(app: self.app)

    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        self.addHeaderViewController()
        self.addDescriptionViewController()
    }
    
    private func addHeaderViewController() {
        self.addChild(self.headerViewController)
        self.view.addSubview(self.headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        
        self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
    }
    
    private func addDescriptionViewController() {
        self.addChild(self.whatsnewViewController)
        self.view.addSubview(self.whatsnewViewController.view)
        self.whatsnewViewController.didMove(toParent: self)
        
        self.whatsnewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.whatsnewViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            self.whatsnewViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.whatsnewViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        /*let descriptionViewController = UIViewController()
        
        self.addChild(descriptionViewController)
        self.view.addSubview(descriptionViewController.view)
        descriptionViewController.didMove(toParent: self)
        
        descriptionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
            descriptionViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            descriptionViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            descriptionViewController.view.heightAnchor.constraint(equalToConstant: 250.0)
            ])*/
    }
    
    /*public var app: ITunesApp?
    
    private let imageDownloader = ImageDownloader()
    
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationController()
        self.downloadImage()
    }
    
    // MARK: - Private
    
    private func configureNavigationController() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func downloadImage() {
        guard let url = self.app?.iconUrl else { return }
        self.appDetailView.throbber.startAnimating()
        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
            self.appDetailView.throbber.stopAnimating()
            guard let image = image else { return }
            self.appDetailView.imageView.image = image
        }
    }*/
}
