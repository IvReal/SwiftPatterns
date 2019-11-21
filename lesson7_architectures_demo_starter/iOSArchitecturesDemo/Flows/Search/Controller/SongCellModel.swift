//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 21.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let track: String
    let artist: String?
    let collection: String?
}

final class SongCellModelFactory {
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(track: model.trackName,
                             artist: model.artistName,
                             collection: model.collectionName)
    }
}
