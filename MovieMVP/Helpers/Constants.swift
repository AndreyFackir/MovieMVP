//
//  Constants.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import Foundation

struct Constants {
  static let apiKey = "8f85c9f0530dd1d153bbd02fef614af1"
  static let movieString = "https://api.themoviedb.org/3/movie/popular?api_key=\(Constants.apiKey)"
  static let serialString = "https://api.themoviedb.org/3/discover/tv?api_key=\(Constants.apiKey)"
  static let posterUrl = "https://image.tmdb.org/t/p/original"
}
