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
    
    // Define an array of local data for the circles
    let circleData: [CircleData] = [
        CircleData(color: Color.red, text: "Circle 1"),
        CircleData(color: Color.green, text: "Circle 2"),
        CircleData(color: Color.blue, text: "Circle 3"),
        CircleData(color: Color.red, text: "Circle 4"),
        CircleData(color: Color.green, text: "Circle 5"),
        CircleData(color: Color.blue, text: "Circle 6"),
        CircleData(color: Color.red, text: "Circle 7"),
        CircleData(color: Color.green, text: "Circle 8"),
        CircleData(color: Color.blue, text: "Circle 9"),
        CircleData(color: Color.red, text: "Circle 10"),
        CircleData(color: Color.green, text: "Circle 11"),
        CircleData(color: Color.blue, text: "Circle 12"),
        CircleData(color: Color.red, text: "Circle 13"),
        CircleData(color: Color.green, text: "Circle 14"),
        CircleData(color: Color.blue, text: "Circle 15"),
        CircleData(color: Color.red, text: "Circle 16"),
        CircleData(color: Color.green, text: "Circle 17"),
        CircleData(color: Color.blue, text: "Circle 18"),
        CircleData(color: Color.red, text: "Circle 19"),
        CircleData(color: Color.green, text: "Circle 20"),
        CircleData(color: Color.blue, text: "Circle 21"),
        
    ]

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
                        ForEach(circleData.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                // Create a ZStack to overlay Circle and Text
                                ZStack {
                                    Circle()
                                        .frame(width: circleSize(for: geometry.frame(in: .global).midX, index: index), height: circleSize(for: geometry.frame(in: .global).midX, index: index))
                                        .foregroundColor(circleData[index].color)
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
                                    
                                    Text(circleData[index].text)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                            }
                            .frame(width: 100, height: 600)
                        }
                    }
                }
                .padding(16)
                
            }
        }
        .onAppear(perform: {
            // Load movie data when the view appears
            //viewModel.loadData() // You can comment out this line if you're using local data
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

// Struct to represent circle data including color and text
struct CircleData {
    let color: Color
    let text: String
}
