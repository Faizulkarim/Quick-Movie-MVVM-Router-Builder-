//
//  BuilderFactory.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation

protocol BuilderFactory {
    func splashBuilder() -> SplashBuildable
    func homeBuilder() -> HomeBuildable
    func favoriteBuilder() -> FavoritesBuildable
    func movieDetailsBuilder() -> MovieDetailsBuildable
}
