//
//  MovieManager.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import CoreData
import UIKit

class MovieManager {
    static let shared = MovieManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addMovie(id: Int64, title: String, releaseDate: String, posterImage: String, language: String, avgRating: Double, popularity: Double) {
        let movie = FavoriteMovie(context: context)
        movie.id = id
        movie.name = title
        movie.releaseDate = releaseDate
        movie.posterImage = posterImage
        movie.language = language
        movie.avgRating = avgRating
        movie.popularity = popularity
        
        saveContext()
    }

    func fetchMovies() -> [FavoriteMovie] {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
    
    func fetchMovieById(id: Int) -> FavoriteMovie? {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let movies = try context.fetch(fetchRequest)
            return movies.first
        } catch {
            print("Failed to fetch movie with id \(id): \(error)")
            return nil
        }
    }

    func deleteMovie(_ movie: FavoriteMovie) {
        context.delete(movie)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
