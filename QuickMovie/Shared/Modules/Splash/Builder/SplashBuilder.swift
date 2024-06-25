//
//  SplashBuilder.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit

// MARK: Module Builder
/// Builder class to build module
final class SplashBuilder: SplashBuildable {

    // MARK: Properties
    /// Dependency manager.
    let dependencyManager: DependencyManager

    // MARK: Init/Deinit
    /// Creates new instance with provided dependencies.
    ///
    /// - Parameters:
    ///   - dependencyManager: Dependency manager.
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }

    // MARK: Protocol conformance

    // MARK: SplashBuildable
    func build() -> UIViewController {
        let viewModel = SplashViewModel(apiManager: dependencyManager.apiManager())
        let view = buildView(viewModel: viewModel, router: buildRouter())
        return view
    }
    
    // MARK: Instance functions

    // MARK: Private Instance Functions
    private func buildView(viewModel: SplashViewModel, router: SplashRouter) -> SplashViewController {
        let theme = dependencyManager.theme()
        let analyticsManager = dependencyManager.analyticsManager()

        let viewController = SplashViewController(analyticsManager: analyticsManager,
                                                                     theme: theme,
                                                                     viewModel: viewModel,
                                                                     router: router)

        return viewController
    }

    private func buildRouter() -> SplashRouter {
        return SplashRouter(dependencyManager: self.dependencyManager)
    }
}
