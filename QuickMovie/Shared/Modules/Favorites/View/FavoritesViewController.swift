//
//  FavoritesViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: FavoritesViewController
final class FavoritesViewController: BaseFavoritesViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var movies: [FavoriteMovie] = []
    
    private var router: FavoritesRouter?
    private let viewModel: FavoritesViewModelType

    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: FavoritesViewModelType,
         router: FavoritesRouter) {
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
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
}

extension FavoritesViewController {
    func fetchMovies() {
            movies = MovieManager.shared.fetchMovies()
            self.favoriteCollectionView.reloadData()
        }
}

// MARK: Private Default Methods
private extension FavoritesViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        favoriteCollectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.reloadData()
    }

    /// Bind viewmodel
    private func bind(to viewModel: FavoritesViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = FavoritesViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: FavoritesViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        }
    }
    
}

extension FavoritesViewController : FavoriteCollectionViewCellDelegate {
    func favoriteButtonTapped(index: Int?) {
        MovieManager.shared.deleteMovie(movies[index ?? 0])
        fetchMovies()
    }
    
    
}


extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  movies.count
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: FavoriteCollectionViewCell.self),
                                                         for: indexPath) as? FavoriteCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            cell.delegate = self
            let name = movies[indexPath.row].name
            let releaseYear = movies[indexPath.row].releaseDate
            let postImage = "\(Constants.posterBaseUrl)\(movies[indexPath.row].posterImage ?? "")"
            cell.configureCell(name: name, releaseYear: releaseYear, posterImage: postImage)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.favoriteCollectionView.frame.width / 3) - 5, height: 210)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
        
    }

}


