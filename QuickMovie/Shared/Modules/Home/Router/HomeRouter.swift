//
//  HomeRouter.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import Foundation
import UIKit

/// HomeRouter list router. Responsible for navigating from the view.
final class HomeRouter {
    /// The navigation controller to use for navigation.
    weak var navigationController: UINavigationController?
    
    /// View controller used to present other views.
    weak var viewController: UIViewController?
    private let dependencyManager: DependencyManager
    
    /// Initializes the view router.
    ///
    /// - Parameter dependencyManager: The app dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    // MARK: - Instance functions
    
    /*
    /// Example method to implement for route.
    ///
    func routeToView() {}
    */
    
    func routeToMovieDetails(movieItem: Movie?) {
        if let vc = dependencyManager.movieDetailsBuilder().build() as? MovieDetailsViewController {
            vc.displayModel.movieItemData = movieItem
            let nc =  UINavigationController(rootViewController:vc)
            nc.modalPresentationStyle = .overFullScreen
            nc.navigationBar.isHidden = true
            self.navigationController?.present(nc, animated: true, completion: nil)
        }
    }
}
