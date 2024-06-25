//
//  HomeViewModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import Combine

// MARK: HomeViewModel
final class HomeViewModel {
    
    // MARK: Private variables
    private var disposeBag: DisposeBag = DisposeBag()
    private let apiManager: OTAPIManager
    private var displayModel: HomeDisplayModel = HomeDisplayModel()

    // MARK: Init Functions

    /// Initializes the model
    ///
    /// - Parameters:
    ///   - apiManager: APIManager manager.
    init(apiManager: OTAPIManager) {
        self.apiManager = apiManager
    }

    private func viewModels<T>(from models: [T]) -> [HomeDisplayModel] {
        return models.map { HomeDisplayModelBuilder.viewModel(from: $0)}
    }
    
}

// MARK: HomeViewModelType

/// Get HomeViewModelType protocol methods
extension HomeViewModel: HomeViewModelType {

    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        /// Clear all observer
        disposeBag.cancel()

        // Observe viewDidload event and perform action
        let viewDidLoadPublisher = input.viewDidLoad
            .map({ input -> HomeViewState in
                return .viewDidLoad
                })
            .eraseToAnyPublisher()
        
        let nowPlahingApiPublisher: PassthroughSubject<HomeViewState, Never> = .init()
        input.nowPlayingApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> in
            nowPlahingApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.nowPlaying()
        }.sink { result in
            DispatchQueue.main.async {
                nowPlahingApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    nowPlahingApiPublisher.send(.nowPlayingApiSuccess(response: response))
                case .failure(let error):
                    nowPlahingApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)
        
        let trendingApiPublisher: PassthroughSubject<HomeViewState, Never> = .init()
        input.nowPlayingApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> in
            trendingApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.trendingMovie()
        }.sink { result in
            DispatchQueue.main.async {
                trendingApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    trendingApiPublisher.send(.trendingApiSuccess(response: response))
                case .failure(let error):
                    trendingApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)
        
        let popularApiPublisher: PassthroughSubject<HomeViewState, Never> = .init()
        input.popularApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> in
            popularApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.popularMovie(param: requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                popularApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    popularApiPublisher.send(.popularApiSuccess(response: response))
                case .failure(let error):
                    popularApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)
        
        let upcomingApiPublisher: PassthroughSubject<HomeViewState, Never> = .init()
        input.upcomingApiSubject.flatMap { requestModel -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> in
            upcomingApiPublisher.send(.loading(shouldShow: true))
            return self.apiManager.upcomingMovie(param: requestModel)
        }.sink { result in
            DispatchQueue.main.async {
                upcomingApiPublisher.send(.loading(shouldShow: false))
                switch result {
                case .success(let response):
                    upcomingApiPublisher.send(.upcomingApiSuccess(response: response))
                case .failure(let error):
                    upcomingApiPublisher.send(.apiFailure(customError: error))
                }
            }
        }.store(in: disposeBag)


        let viewDidLoadAndLoadDataPublisher = Publishers.MergeMany(viewDidLoadPublisher,nowPlahingApiPublisher.eraseToAnyPublisher(), trendingApiPublisher.eraseToAnyPublisher(),popularApiPublisher.eraseToAnyPublisher(),upcomingApiPublisher.eraseToAnyPublisher()).eraseToAnyPublisher()

        // If there any service call during view load so call it and
        // return success with response model or just return empty
        // response with success call as below
        return HomeViewModelOutput.init(viewState: viewDidLoadAndLoadDataPublisher)
    }

}
