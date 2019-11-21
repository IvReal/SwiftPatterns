//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        /*
         //let rootVC = SearchViewController()
         let rootVC = SearchModuleBuilder.build()
         rootVC.navigationItem.title = "Search via iTunes"
         
         let navVC = self.configuredAppNC
         navVC.viewControllers = [rootVC]
         
         window?.rootViewController = navVC
         window?.makeKeyAndVisible()
         */

        let tabVC = UITabBarController()
        
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
        let rootAppVC = SearchModuleBuilder.build()
        rootAppVC.navigationItem.title = "Search Apps via iTunes"
        let tabApp = UITabBarItem(title: "App", image: UIImage(named: "settings32"), tag: 0)
        let navAppVC = self.configuredAppNC
        navAppVC.viewControllers = [rootAppVC]
        navAppVC.tabBarItem = tabApp
        
        let rootSongVC = SearchSongModuleBuilder.build()
        rootSongVC.navigationItem.title = "Search Songs via iTunes"
        let tabSong = UITabBarItem(title: "Song", image: UIImage(named: "friends48"), tag: 0)
        let navSongVC = configuredSongNC
        navSongVC.viewControllers = [rootSongVC]
        navSongVC.tabBarItem = tabSong

        tabVC.viewControllers = [navAppVC, navSongVC];
    }
    
    private lazy var configuredAppNC: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.backgroundColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
    
    private lazy var configuredSongNC: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.blue
        navVC.navigationBar.backgroundColor = UIColor.blue
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}
