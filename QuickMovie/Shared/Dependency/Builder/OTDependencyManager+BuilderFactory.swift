//
//  OTDependencyManager+BuilderFactory.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation

extension OTDependencyManager {
    func splashBuilder() -> SplashBuildable {
        return SplashBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    func homeBuilder() -> HomeBuildable {
        return HomeBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
    func favoriteBuilder() -> FavoritesBuildable {
        return FavoritesBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    func movieDetailsBuilder() -> MovieDetailsBuildable {
        return MovieDetailsBuilder(dependencyManager: OTDependencyManager.defaultValue)
    }
    
}
