//
//  HomeViewModelType.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: HomeViewModelInput
struct HomeViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let nowPlayingApiSubject : AnyPublisher<Void, Never>
    let trendingApiSubject : AnyPublisher<Void, Never>
    let popularApiSubject : AnyPublisher<Parameters, Never>
    let upcomingApiSubject : AnyPublisher<Parameters, Never>
}

// MARK: ViewModelOutput
struct HomeViewModelOutput {
    let viewState: AnyPublisher<HomeViewState, Never>
}

// MARK: ViewState
enum HomeViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case nowPlayingApiSuccess(response: MovieResponseModel?)
    case trendingApiSuccess(response: MovieResponseModel?)
    case popularApiSuccess(response: MovieResponseModel?)
    case upcomingApiSuccess(response: MovieResponseModel?)
}

// MARK: HomeViewModelType
protocol HomeViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput
}
