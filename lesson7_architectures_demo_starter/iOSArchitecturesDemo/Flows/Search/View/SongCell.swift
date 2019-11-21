//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 21.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    // MARK: - Subviews
    
    private(set) lazy var noteView: UIImageView = {
        let noteView = UIImageView()
        noteView.translatesAutoresizingMaskIntoConstraints = false
        noteView.layer.cornerRadius = 10.0
        noteView.layer.masksToBounds = true
        noteView.image = UIImage(named: "note48")
        return noteView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.track
        self.artistLabel.text = cellModel.artist
        self.collectionLabel.text = cellModel.collection
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.artistLabel, self.collectionLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addNoteImage()
        self.addTitleLabel()
        self.addArtistLabel()
        self.addCollectionLabel()
    }
    
    private func addNoteImage() {
        self.contentView.addSubview(self.noteView)
        NSLayoutConstraint.activate([
            self.noteView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.noteView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.noteView.widthAnchor.constraint(equalToConstant: self.noteView.image?.size.width ??  48.0)
            ])
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.noteView.rightAnchor, constant: 5.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addArtistLabel() {
        self.contentView.addSubview(self.artistLabel)
        NSLayoutConstraint.activate([
            self.artistLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.artistLabel.leftAnchor.constraint(equalTo: self.noteView.rightAnchor, constant: 5.0),
            self.artistLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }
    
    private func addCollectionLabel() {
        self.contentView.addSubview(self.collectionLabel)
        NSLayoutConstraint.activate([
            self.collectionLabel.topAnchor.constraint(equalTo: self.artistLabel.bottomAnchor, constant: 4.0),
            self.collectionLabel.leftAnchor.constraint(equalTo: self.noteView.rightAnchor, constant: 5.0),
            self.collectionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0)
            ])
    }

}
