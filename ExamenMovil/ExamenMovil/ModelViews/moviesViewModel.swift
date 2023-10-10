//
//  moviesViewModel.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private let movieRepository: MoviesRepository
    
    init(movieRepository: MoviesRepository) {
        self.movieRepository = movieRepository
    }
    
    func loadData() {
        movieRepository.fetchPopularMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedMovies):
                DispatchQueue.main.async {
                    self.movies = fetchedMovies
                }
            case .failure(let error):
                print("Error loading movies: \(error.localizedDescription)")
            }
        }
    }
}

