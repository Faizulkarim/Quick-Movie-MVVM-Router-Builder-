//
//  MovieDetailsDisplayModelBuilder.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import Combine

// MARK: MovieDetailsDisplayModelBuilder
struct MovieDetailsDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> MovieDetailsDisplayModel {
        return MovieDetailsDisplayModel()
    }
}
