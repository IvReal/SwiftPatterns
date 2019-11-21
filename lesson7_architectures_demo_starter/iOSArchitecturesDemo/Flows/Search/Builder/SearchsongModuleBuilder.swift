//
//  SearchsongModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Iv on 21.11.2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SearchSongModuleBuilder {
    
    static func build() -> (UIViewController & SearchSongViewInput) {
        let presenter = SearchSongPresenter()
        let viewController = SearchSongViewController(presenter: presenter)
        presenter.viewInput = viewController
        return viewController
    }
}

