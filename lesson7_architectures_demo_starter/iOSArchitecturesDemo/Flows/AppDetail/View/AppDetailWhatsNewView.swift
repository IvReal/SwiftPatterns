//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 20.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewView: UIView {

    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
       
    // MARK: - Init
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
       
    // MARK: - UI
       
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.versionLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.descriptionLabel)
           
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
                
            self.versionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.versionLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.versionLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.versionLabel.bottomAnchor, constant: 12.0),
            self.dateLabel.leftAnchor.constraint(equalTo: self.versionLabel.leftAnchor),
            self.dateLabel.rightAnchor.constraint(equalTo: self.versionLabel.rightAnchor),
        
            self.descriptionLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 12.0),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.dateLabel.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.dateLabel.rightAnchor),
        ])
    }

}
