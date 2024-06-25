//
//  MovieDetailsViewModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: MovieDetailsViewModel
final class MovieDetailsViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: MovieDetailsDisplayModel = MovieDetailsDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [MovieDetailsDisplayModel] {
        return models.map { MovieDetailsDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: MovieDetailsViewModelType

/// Get MovieDetailsViewModelType protocol methods
extension MovieDetailsViewModel: MovieDetailsViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: MovieDetailsViewModelInput) -> MovieDetailsViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> MovieDetailsViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()
        
        let relatedApiPublisher: PassthroughSubject<MovieDetailsViewState, Never> = .init()
        input.relatedApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> in
            relatedApiPublisher.send(.loading(shouldShow: true))
            let id = requestModel["id"] as! Int
            return self.apiManager.relatedMovie(id.description)
        }.sink { result in
            DispatchQueue.main.async {
                relatedApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    relatedApiPublisher.send(.relatedApiSuccess(response: response))
                case .failure(let error):
                    relatedApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)


        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,relatedApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return MovieDetailsViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
