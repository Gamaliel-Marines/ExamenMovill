//
//  moviesRepository.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import Foundation

protocol MoviesRepository {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

class MoviesRepositoryImpl: MoviesRepository {
    private let apiKey = "https://api.themoviedb.org/3/movie/popular"
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Perform the HTTP request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
