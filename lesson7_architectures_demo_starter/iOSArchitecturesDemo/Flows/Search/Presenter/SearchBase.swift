//
//  SearchBase.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 21.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInputBase {
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewInput: class, SearchViewInputBase {
    var searchResults: [ITunesApp] { get set }
}

protocol SearchSongViewInput: class, SearchViewInputBase {
    var searchResults: [ITunesSong] { get set }
}

protocol SerachViewOutputBase {
    func viewDidSearch(with query: String)
}

protocol SearchViewOutput: class, SerachViewOutputBase {
    func viewDidSelectApp(_ app: ITunesApp)
}

protocol SearchSongViewOutput: class, SerachViewOutputBase {
    func viewDidSelectSong(_ app: ITunesSong)
}

