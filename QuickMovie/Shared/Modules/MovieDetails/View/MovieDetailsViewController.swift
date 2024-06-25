//
//  MovieDetailsViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: MovieDetailsViewController
final class MovieDetailsViewController: BaseMovieDetailsViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: OTDynamicButton!
    
    private var router: MovieDetailsRouter?
    private let viewModel: MovieDetailsViewModelType

    var displayModel = MovieDetailsDisplayModel()
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let relatedApiSubject = PassthroughSubject<Parameters, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: MovieDetailsViewModelType,
         router: MovieDetailsRouter) {
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
        self.getRelatedMovie()
    }
    
}

// MARK: Private Default Methods
private extension MovieDetailsViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        tableView.registerCell(MovieDetailsTableCell.self)
        tableView.registerCell(OverviewTableViewCell.self)
        tableView.registerCell(RelatedMovieTableViewCell.self)
        loadDefultView()
    }
    
    func loadDefultView() {
        let backButtonViewModel = OTDynamicButtonViewModel(img: theme.imageTheme.navBack.withRenderingMode(.alwaysOriginal),title: "", tintColor: theme.colorTheme.colorPrimaryRed, titleFont: nil, titleColor: theme.colorTheme.clearColor, backgroundColor: theme.colorTheme.colorPrimaryBlack, borderColor: theme.colorTheme.clearColor, cornerRadius: 0, isHidden: false)
        self.backButton.configureView(viewModel: backButtonViewModel) { [weak self] sender in
            self?.router?.back()
        }
    }

    /// Bind viewmodel
    private func bind(to viewModel: MovieDetailsViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = MovieDetailsViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), relatedApiSubject: relatedApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: MovieDetailsViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            showToast(message: customError.body)
        case .relatedApiSuccess(response: let response):
            self.displayModel.relatedMovie = response?.data
            self.tableView.reloadData()
        }
    }
    
}

extension MovieDetailsViewController {
    func getRelatedMovie() {
        let param: Parameters = [
            "id": self.displayModel.movieItemData?.id ?? 0
        ]
        self.relatedApiSubject.send(param)
    }
}
extension MovieDetailsViewController : RelatedMovieTableViewCellDelegate {
    func tapOnMovieItem(movieItem: Movie?) {
        self.displayModel.movieItemData = movieItem
        self.tableView.reloadData()
        self.getRelatedMovie()
    }
}

extension MovieDetailsViewController : MovieDetailsTableCellDelegate {
    func favoirteButtonTapped(index: Int?) {
        let movieManager = MovieManager.shared
        let MovieById = movieManager.fetchMovieById(id: self.displayModel.movieItemData?.id ?? 0)
        if let MovieById = MovieById {
            movieManager.deleteMovie(MovieById)
        }else {
            movieManager.addMovie(id: Int64(self.displayModel.movieItemData?.id ?? 0), title: self.displayModel.movieItemData?.title ?? "", releaseDate: self.displayModel.movieItemData?.releaseDate ?? "", posterImage: self.displayModel.movieItemData?.posterPath ?? "", language: self.displayModel.movieItemData?.originalLanguage ?? "", avgRating: self.displayModel.movieItemData?.voteAverage ?? 0.0, popularity: self.displayModel.movieItemData?.popularity ?? 0.0)
        }
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MovieDetailsTableCell
        cell?.setupFavoriteButton()
    }
}

// MARK: Private Actions
extension MovieDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        if let validMoviDetailsCellViewModel = self.displayModel.dataSource[indexPath.row] as? MovieDetailsTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableCell.nameId) as! MovieDetailsTableCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validMoviDetailsCellViewModel)
            return cell
        }else if let validMovieOverviewCellModel = self.displayModel.dataSource[indexPath.row] as? MovieOverviewTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.nameId) as! OverviewTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.configureCell(overViewText: validMovieOverviewCellModel.overview)
            return cell
        }else if let validRelatedCellViewModel = self.displayModel.dataSource[indexPath.row] as? RelatedMovieTableCellViewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: RelatedMovieTableViewCell.nameId) as! RelatedMovieTableViewCell
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureCell(cellViewModel: validRelatedCellViewModel)
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
