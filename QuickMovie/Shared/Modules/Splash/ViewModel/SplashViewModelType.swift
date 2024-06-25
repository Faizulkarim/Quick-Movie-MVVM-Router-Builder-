//
//  SplashViewModelType.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import Combine

// MARK: SplashViewModelInput
struct SplashViewModelInput {
    let viewDidLoad: AnyPublisher<Void, Never>
}

// MARK: ViewModelOutput
struct SplashViewModelOutput {
    let viewState: AnyPublisher<SplashViewState, Never>
}

// MARK: ViewState
enum SplashViewState {
    case viewDidLoad
}

// MARK: SplashViewModelType
protocol SplashViewModelType {
    /// Passing input publishers to get output publishers for sink i.e to observe
    func transform(input: SplashViewModelInput) -> SplashViewModelOutput
}
