//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 21.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SearchSongPresenter {
        
    weak var viewInput: (UIViewController & SearchSongViewInput)?
        
    private let searchService = ITunesSearchService()
        
    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result
                .withValue { songs in
                    guard !songs.isEmpty else {
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = songs
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
        
    private func openSongDetails(with song: ITunesSong) {
    }
}
    
// MARK: - SearchViewOutput
extension SearchSongPresenter: SearchSongViewOutput {
        
    func viewDidSearch(with query: String) {
        self.viewInput?.throbber(show: true)
        self.requestSongs(with: query)
    }
        
    func viewDidSelectSong(_ app: ITunesSong) {
        self.openSongDetails(with: app)
    }
}

