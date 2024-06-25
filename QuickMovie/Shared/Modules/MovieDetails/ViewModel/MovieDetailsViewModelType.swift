//
//  MovieDetailsViewModelType.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

// MARK: MovieDetailsViewModelInput
struct MovieDetailsViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
    let relatedApiSubject : AnyPublisher<Parameters, Never>
}

// MARK: ViewModelOutput
struct MovieDetailsViewModelOutput {
    let viewState: AnyPublisher<MovieDetailsViewState, Never>
}

// MARK: ViewState
enum MovieDetailsViewState {
    case viewDidLoad
    case loading(shouldShow: Bool)
    case apiFailure(customError: OTError)
    case relatedApiSuccess(response: MovieResponseModel?)
}

// MARK: MovieDetailsViewModelType
protocol MovieDetailsViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: MovieDetailsViewModelInput) -> MovieDetailsViewModelOutput
}
