//
//  LaunchSequencer.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation

import UIKit
import CoreAudio

/// Describes events and their order for application launch.
final class LaunchSequencer {
    
    private let rootWindow: UIWindow?
    private let dependencyManager: DependencyManager
    
    // MARK: - Init/Deinit
    
    init(rootWindow: UIWindow?,
         dependencyManager: DependencyManager) {
        self.rootWindow = rootWindow
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /// Runs sequence of steps that should occur at launch
    /// to ensure proper application state and appearance.
    func launch() {
        installRootView()
    }
    private func installRootView() {
        let appView = self.dependencyManager.splashBuilder().build()
        appView.navigationController?.navigationBar.isHidden = true
        self.rootWindow?.rootViewController = appView
        self.rootWindow?.makeKeyAndVisible()
    }
    
    func loadLandingPageOn(controller: UIViewController?) {
        let tabBar = BaseTabBarViewController.createObj()
        let baseNav = BaseNavigationViewController.createObj(with: tabBar)
        baseNav.isNavigationBarHidden = true
        baseNav.modalPresentationStyle = .overFullScreen
        controller?.present(baseNav, animated: true)
    }
    

}
