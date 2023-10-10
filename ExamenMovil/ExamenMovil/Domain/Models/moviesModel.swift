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

}

struct MovieResponse: Codable {
    var results: [Movie]
}
