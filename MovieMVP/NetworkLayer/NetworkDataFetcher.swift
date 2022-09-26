//
//  NetworkDataFetcher.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

protocol NetworkDataFetcherProtocol {
  func fetchDataMovies(url: String, response: @escaping(MovieModel?) -> Void)
  func fetchTVShows(url: String, response: @escaping (SerialModel?) -> Void)
  func fetchSerialAndMovieCast(url: String, completion: @escaping (SerialAndMoviesCast?) -> Void)
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
  func fetchDataMovies(url: String, response: @escaping (MovieModel?) -> Void) {
    NetworkService.request(urlString: url) { result in
      switch result {
        case .success(let data):
          do {
            let movies = try JSONDecoder().decode(MovieModel.self, from: data)
            response(movies)
          } catch let jsonError {
            print("Fail to decode JSON", jsonError)
            response(nil)
          }
        case .failure(let error):
          print("Error received requesting data", error)
          response(nil)
      }
    }
  }
  
  func fetchTVShows(url: String, response: @escaping (SerialModel?) -> Void) {
    NetworkService.request(urlString: url) { result in
      switch result {
        case .success(let data):
          do {
            let serials = try JSONDecoder().decode(SerialModel.self, from: data)
            response(serials)
          } catch let jsonError {
            print("Fail to decode JSON", jsonError)
            response(nil)
          }
        case .failure(let error):
          print("Error receive requesting data", error)
          response(nil)
      }
    }
  }
  
  func fetchSerialAndMovieCast(url: String, completion: @escaping (SerialAndMoviesCast?) -> Void) {
    NetworkService.request(urlString: url) { result in
      switch result {
        case .success(let data):
          do {
            let cast = try JSONDecoder().decode(SerialAndMoviesCast.self, from: data)
            DispatchQueue.main.async {
              completion(cast)
            }
          } catch let jsonError {
            print("Fail to decode JSON", jsonError)
            DispatchQueue.main.async {
              completion(nil)
            }
          }
        case .failure(let error):
          print("Error receive requesting data", error)
          DispatchQueue.main.async {
            completion(nil)
          }
      }
    }
  }
}
