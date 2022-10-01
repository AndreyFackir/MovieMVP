//
//  MovieModel.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import Foundation

struct MovieModel: Codable {
  let results: [Movies]
}

struct Movies: Codable {
  let originalTitle: String
  let overview: String
  let posterPath: String
  let releaseDate: String
  let voteAverage: Double
  let id: Int
  
  enum CodingKeys: String, CodingKey {
    case originalTitle = "original_title"
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case overview, id
  }
}
