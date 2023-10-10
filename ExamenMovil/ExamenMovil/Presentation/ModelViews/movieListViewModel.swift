//
//  movieListViewModel.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import Foundation

class movieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private let movieRepository: MoviesRepository
    
    init(movieRepository: MoviesRepository) {
        self.movieRepository = movieRepository
    }
    
    func loadData() {
        movieRepository.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

