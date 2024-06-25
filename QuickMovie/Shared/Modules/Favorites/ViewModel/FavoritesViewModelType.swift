//
//  FavoritesViewModelType.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: FavoritesViewModelInput
struct FavoritesViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct FavoritesViewModelOutput {
    let viewState: AnyPublisher<FavoritesViewState, Never>
}

// MARK: ViewState
enum FavoritesViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
}

// MARK: FavoritesViewModelType
protocol FavoritesViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FavoritesViewModelInput) -> FavoritesViewModelOutput
}
