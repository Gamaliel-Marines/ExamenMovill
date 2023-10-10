//
//  moviesModel.swift
//  ExamenMovil
//
//  Created by Gamaliel Marines on 10/10/23.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String
    // Agrega más propiedades según sea necesario
}

struct MovieResponse: Codable {
    var results: [Movie]
}
