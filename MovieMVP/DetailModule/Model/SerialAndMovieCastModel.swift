//
//  SerialAndMovieCastModel.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 30.08.2022.
//

import Foundation

struct SerialAndMoviesCast: Codable {
  let cast: [SerialAndMoviesCastModel]
  
}

struct SerialAndMoviesCastModel: Codable {
  let name: String
  let character: String?
  let profilePath: String?
  
  enum CodingKeys: String, CodingKey {
    case name, character
    case profilePath = "profile_path"
    
  }
}

