import Foundation

// Protocol that defines the interface for fetching popular movies
protocol MoviesRepository {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

// Enum representing possible network errors
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

// Concrete implementation of the MoviesRepository protocol
class MoviesRepositoryImpl: MoviesRepository {
    // Authentication key for the movie API (Not recommended to store it in the code!)
    private let apiKey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZjhkZDc1NmUzMmI4YWNlZjYyZmQ2YzMwZmQwY2NmOSIsInN1YiI6IjY0ZWI9MzhiZTg5NGE2MDEzYmIxNjNjZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6cGDTI8wql15qnVZErrd_6QRNaiRAi74pRD0LfOzVZM"
    
    // Method to fetch popular movies
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        // Build the URL for the request to fetch popular movies
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Perform the HTTP request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // In case of an error in the request, call the completion closure with the error
                completion(.failure(error))
                return
            }
            
            // Check if the HTTP response is valid (status code 200)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            // Check if data was received in the response
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                // Decode the JSON response into a MovieResponse object
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                
                // Call the completion closure with the list of movies as a success
                completion(.success(movieResponse.results))
            } catch {
                // In case of an error in decoding, call the completion closure with the error
                completion(.failure(error))
            }
        }.resume() // Start the HTTP request task
    }
}
