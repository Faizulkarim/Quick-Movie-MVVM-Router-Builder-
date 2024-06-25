//
//  SplashViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit
import Combine

// MARK: SplashViewController
final class SplashViewController: BaseSplashViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var router: SplashRouter?
    private let viewModel: SplashViewModelType

    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: SplashViewModelType,
         router: SplashRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
    }
    
}

// MARK: Private Default Methods
private extension SplashViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }


    /// Bind viewmodel
    private func bind(to viewModel: SplashViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = SplashViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: SplashViewState) {
        switch state {
        case .viewDidLoad:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.router?.routeToHome()
            }
            
        }
    }
    
}
