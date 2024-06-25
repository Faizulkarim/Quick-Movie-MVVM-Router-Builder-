//
//  FavoritesDisplayModelBuilder.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import Combine

// MARK: FavoritesDisplayModelBuilder
struct FavoritesDisplayModelBuilder {
    
    /// Transform the response model to display model
    ///
    /// - Parameters:
    ///   - model: Codable model.
    static func viewModel<T>(from model: T) -> FavoritesDisplayModel {
        return FavoritesDisplayModel()
    }
}
