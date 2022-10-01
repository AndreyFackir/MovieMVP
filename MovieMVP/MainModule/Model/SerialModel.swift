//
//  TVShowsModel.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 29.08.2022.
//

import Foundation

struct SerialModel: Codable {
  let results: [TVShows]
}

struct TVShows: Codable {
  let name: String
  let overview: String
  let posterPath: String
  let voteAverage: Double
  let firstAirDate: String
  let id: Int
  
  enum CodingKeys: String, CodingKey {
    case name, id
    case overview
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case firstAirDate = "first_air_date"
  }
}
