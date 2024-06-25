//
//  MovieDetailsDisplayModel.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation

protocol MovieDetailsPassableModel { }
// MARK: MovieDetailsDisplayModel
struct MovieDetailsDisplayModel {
    var dataSource = [MovieDetailsPassableModel]()
    var movieItemData: Movie? {
        didSet {
            loadCellViewModel()
        }
    }
    var relatedMovie : [Movie]? {
        didSet {
            loadCellViewModel()
        }
    }
    mutating func loadCellViewModel() {
        self.dataSource.removeAll()
        if let movieItemData = movieItemData {
            let coverImage = "\(Constants.posterBaseUrl)\(movieItemData.backdropPath ?? "")"
            let posterImage = "\(Constants.posterBaseUrl)\(movieItemData.posterPath ?? "")"
            let releaseDate = "Released on \( AppUtilities.shared.convertMovieReleaseDate(dateString: movieItemData.releaseDate ?? ""))"
            let language = "language is \(movieItemData.originalLanguage ?? "")"
            let popularity = "Popularity \(movieItemData.popularity ?? 0.0)"
            let avgRating = "Average rating \(movieItemData.voteAverage ?? 0.0)"
            self.dataSource.append(MovieDetailsTableCellViewModel(id: movieItemData.id, name: movieItemData.title, coverImage: coverImage, posterImage: posterImage, releaseDate: releaseDate, language: language, popularity: popularity, avgRating: avgRating))
            self.dataSource.append(MovieOverviewTableCellViewModel(overview: movieItemData.overview))
        }
        if let relatedMovie = relatedMovie {
            self.dataSource.append(RelatedMovieTableCellViewModel(data: relatedMovie, title: "Related Movies"))
        }
        
    }

}

struct MovieDetailsTableCellViewModel : MovieDetailsPassableModel {
    let id : Int?
    let name: String?
    let coverImage: String?
    let posterImage: String?
    let releaseDate: String?
    let language : String?
    let popularity: String?
    let avgRating: String?
}

struct MovieOverviewTableCellViewModel : MovieDetailsPassableModel {
    let overview: String?
}

struct RelatedMovieTableCellViewModel : MovieDetailsPassableModel {
    let data : [Movie]?
    let title: String?
}
