//
//  SplashViewModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import UIKit
import Combine

// MARK: SplashViewModel
final class SplashViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: SplashDisplayModel = SplashDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [SplashDisplayModel] {
        return models.map { SplashDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: SplashViewModelType

/// Get SplashViewModelType protocol methods
extension SplashViewModel: SplashViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SplashViewModelInput) -> SplashViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> SplashViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return SplashViewModelOutput.init(viewState: viewDidLoadPublisher)
    }

}
