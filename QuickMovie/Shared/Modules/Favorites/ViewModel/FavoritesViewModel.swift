//
//  FavoritesViewModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: FavoritesViewModel
final class FavoritesViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: FavoritesDisplayModel = FavoritesDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [FavoritesDisplayModel] {
        return models.map { FavoritesDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: FavoritesViewModelType

/// Get FavoritesViewModelType protocol methods
extension FavoritesViewModel: FavoritesViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: FavoritesViewModelInput) -> FavoritesViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> FavoritesViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return FavoritesViewModelOutput.init(viewState: viewDidLoadPublisher)
    }

}
