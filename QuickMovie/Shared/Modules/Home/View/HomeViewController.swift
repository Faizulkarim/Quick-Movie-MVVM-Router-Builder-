//
//  HomeViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: HomeViewController
final class HomeViewController: BaseHomeViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var router: HomeRouter?
    private let viewModel: HomeViewModelType
    var displayModel =  HomeDisplayModel()

    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let nowPlayingApiSubject = PassthroughSubject<Void, Never>()
    private let trendingApiSubject = PassthroughSubject<Void, Never>()
    private let popularApiSubject = PassthroughSubject<Parameters, Never>()
    private let upcomingApiSubject = PassthroughSubject<Parameters, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: HomeViewModelType,
         router: HomeRouter) {
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
        setupUI()
        bind(to: viewModel)
        setupRouter()
        viewDidLoadSubject.send()
        self.getNowPlayingMovieList()
        self.getTrendingMovies()
        self.getPopularMovies()
        self.getUpcoingMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNowPlayingMovieList()
        self.getTrendingMovies()
        self.getPopularMovies()
        self.getUpcoingMovies()
    }
    
}

// MARK: Private Default Methods
private extension HomeViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        tableView.registerCell(NowPlayingTableViewCell.self)
        tableView.registerCell(TrendingTableViewCell.self)
        tableView.registerCell(PopularTableViewCell.self)
        tableView.registerCell(UpcomingTableViewCell.self)
    }

    /// Bind viewmodel
    private func bind(to viewModel: HomeViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = HomeViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), nowPlayingApiSubject: nowPlayingApiSubject.eraseToAnyPublisher(), trendingApiSubject: trendingApiSubject.eraseToAnyPublisher(), popularApiSubject: popularApiSubject.eraseToAnyPublisher(), upcomingApiSubject: upcomingApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: HomeViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            showToast(message: customError.body)
        case .nowPlayingApiSuccess(let response):
            self.displayModel.nowPlayingResponseData = response?.data
            self.tableView.reloadData()
        case .trendingApiSuccess(let response):
            self.displayModel.trendingResponseData = response?.data
            self.tableView.reloadData()
        case .popularApiSuccess(response: let response):
            self.displayModel.popularResponseData = response?.data
            self.tableView.reloadData()
        case .upcomingApiSuccess(response: let response):
            self.displayModel.upcomingResponseData = response?.data
            self.tableView.reloadData()
        }
    }
    
}
extension HomeViewController {
    func getNowPlayingMovieList() {
        nowPlayingApiSubject.send()
    }
    
    func getTrendingMovies() {
        trendingApiSubject.send()
    }
    
    func getPopularMovies() {
        let params: Parameters = [
            "page": 1
        ]
        self.popularApiSubject.send(params)
    }
    
    func getUpcoingMovies() {
        let params: Parameters = [
            "page": 1
        ]
        self.upcomingApiSubject.send(params)
    }
}

extension HomeViewController: TrendingTableViewCellDelegate,PopularTableViewCellDelegate, UpcomingTableViewCellDelegate {
    func tapOnMovieItem(movieItem: Movie?) {
        self.router?.routeToMovieDetails(movieItem: movieItem)
    }
}

// MARK: Private Actions
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let validNowPlayingCellViewModel = self.displayModel.dataSource[indexPath.row] as? nowPlayingTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.nameId) as! NowPlayingTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.configureCell(cellViewModel: validNowPlayingCellViewModel)
            return cell
        }else if let validTrendingCellViewModel = self.displayModel.dataSource[indexPath.row] as? trendingTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.nameId) as! TrendingTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validTrendingCellViewModel)
            return cell
        }else if let validPopularCellViewModel = self.displayModel.dataSource[indexPath.row] as? PopularTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.nameId) as! PopularTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validPopularCellViewModel)
            return cell
        }else if let validUpcomingCellViewModel = self.displayModel.dataSource[indexPath.row] as? UpcomingTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.nameId) as! UpcomingTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validUpcomingCellViewModel)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
