//
//  moviesView.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel(movieRepository: MoviesRepositoryImpl())
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(viewModel.movies, id: \.id) { (movie: Movie) in
                    Circle()
                        .frame(width: 100, height: 100) // Set the desired size for your circles
                        .foregroundColor(Color.blue) // Change to your desired circle color
                        .opacity(1.0)
                        .scaleEffect(x: 1.0, y: 1.0)
                        .offset(y: 0)
                }

            }
        }
        .padding(16)
        .onAppear(perform: {
            viewModel.loadData()
        })
    }
}

