//
//  MovieDetailsBuildable.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

/// MovieDetails builder protocol.
protocol MovieDetailsBuildable {

    /// Builds the MovieDetails view.
    ///
    /// - Returns: MovieDetails details view.
    func build() -> UIViewController

}
