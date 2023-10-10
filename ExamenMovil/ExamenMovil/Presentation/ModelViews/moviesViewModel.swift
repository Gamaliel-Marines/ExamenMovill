//
//  moviesViewModel.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import Foundation

// ViewModel for managing a list of movies
class MovieListViewModel: ObservableObject {
    // Published property to notify views when the movies array changes
    @Published var movies = [Movie]()
    
    // Reference to the MoviesRepository used to fetch movie data
    private let movieRepository: MoviesRepository
    
    // Initializer to inject the MoviesRepository dependency
    init(movieRepository: MoviesRepository) {
        self.movieRepository = movieRepository
    }
    
    // Function to load data from the movie repository
    func loadData() {
        // Use the movie repository to fetch popular movies
        movieRepository.fetchPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedMovies):
                // Update the movies array on the main thread
                DispatchQueue.main.async {
                    self.movies = fetchedMovies
                }
            case .failure(let error):
                // Handle and log any errors that occur during data loading
                print("Error loading movies: \(error.localizedDescription)")
            }
        }
    }
}

