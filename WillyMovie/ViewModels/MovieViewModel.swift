//
//  MovieViewModel.swift
//  WillyMovie
//
//  Created by Prabhdeep Singh on 06/10/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    private var movies = Box([MovieElement]())
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
    static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("movies")
    
    func bind(completion: @escaping () -> Void) {
        movies.bind { (_) in
            completion()
        }
    }
    
    var shouldShowIndicator = Box(true)
    
    func retrieveMovies(movie: String) {
          self.shouldShowIndicator.value = true
        MovieService.fetchMovies(movie: movie) { (movieModel, error) in
            
            if let error = error {
                print("Error getting Movies \(error.localizedDescription)")
                self.shouldShowIndicator.value = false
                return
            }
            self.movies.value = movieModel!.search
            self.shouldShowIndicator.value = false
            self.saveMovies(movies: movieModel!)
        }
    }

    
    func getMovieCount() -> Int {
        return movies.value.count
    }
    
    func getMovieTitle(index: Int) -> String {
        return movies.value[index].title
    }
    
    func getMovieYear(index: Int) -> String {
        return movies.value[index].year
    }
    
    func getMovieId(index: Int) -> String {
        return movies.value[index].imdbID
    }
    
    func getMoviePosterUrl(index: Int) -> URL {
        let url = URL(string: movies.value[index].posterUrl)!
        return url
    }
    
    
}

extension MovieViewModel {
    
    private func saveMovies(movies:MovieModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movies) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "movies")
            print("movies saved")
        }
    }
    
    func loadMovies() {
        if let savedMovies = UserDefaults.standard.object(forKey: "movies") as? Data {
            let decoder = JSONDecoder()
            if let loadedMovies = try? decoder.decode(MovieModel.self, from: savedMovies) {
                self.movies.value = loadedMovies.search
            }
        }
    }
}


