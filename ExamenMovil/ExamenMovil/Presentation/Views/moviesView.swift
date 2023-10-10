//
//  moviesView.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import SwiftUI

// View representing a list of movies
struct MovieListView: View {
    // Create a view model for managing movie data
    @StateObject private var viewModel = MovieListViewModel(movieRepository: MoviesRepositoryImpl())
    
    // Track the index of the selected movie
    @State private var selectedMovieIndex = 0

    var body: some View {
        // Create a ZStack to overlay views
        ZStack {
            // Create a linear gradient background
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            // Create a vertical stack for the main content
            VStack {
                Text("Trending Movies")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                // Create a horizontal scroll view for displaying movie circles
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.movies.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                // Create a circle for each movie
                                Circle()
                                    .frame(width: circleSize(for: geometry.frame(in: .global).midX, index: index), height: circleSize(for: geometry.frame(in: .global).midX, index: index))
                                    .foregroundColor(Color.gray)
                                    .opacity(1.0)
                                    .offset(y: 0)
                                    .scaleEffect(selectedMovieIndex == index ? 1.2 : 1.0)
                                    .animation(.easeInOut)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedMovieIndex = index
                                        }
                                    }
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Add shadow here
                            }
                            .frame(width: 100, height: 100)
                        }
                    }
                }
                .padding(16)
                
                // Create a horizontal scroll view for displaying circle indicators
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<10, id: \.self) { index in
                            // Create a circle indicator
                            Circle()
                                .frame(width: circleSize(for: UIScreen.main.bounds.width / 2, index: index), height: circleSize(for: UIScreen.main.bounds.width / 2, index: index))
                                .foregroundColor(Color.white)
                                .opacity(1.0)
                                .offset(y: 0)
                                .scaleEffect(1.0)
                                .animation(.easeInOut)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Add shadow here
                        }
                    }
                }
                .padding(16)
            }
        }
        .onAppear(perform: {
            // Load movie data when the view appears
            viewModel.loadData()
        })
    }

    // Function to calculate the size of the circle based on its position and index
    private func circleSize(for position: CGFloat, index: Int) -> CGFloat {
        let center = UIScreen.main.bounds.width / 2
        let maxCircleSize: CGFloat = 120
        let minCircleSize: CGFloat = 80
        let scaleFactor: CGFloat = 0.5

        let distance = abs(position - center)
        let scale = 1 - min(max(distance / center, 0), 1) * scaleFactor

        return index == selectedMovieIndex ? maxCircleSize : minCircleSize + (maxCircleSize - minCircleSize) * scale
    }
}
