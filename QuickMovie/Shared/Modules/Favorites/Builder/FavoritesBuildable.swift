//
//  FavoritesBuildable.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// Favorites builder protocol.
protocol FavoritesBuildable {

    /// Builds the Favorites view.
    ///
    /// - Returns: Favorites details view.
    func build() -> UIViewController

}
