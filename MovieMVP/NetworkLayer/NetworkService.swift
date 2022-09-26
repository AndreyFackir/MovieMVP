//
//  NetworkService.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

protocol NetworkServiceProtocol {
  static func request(urlString: String, completion: @escaping(Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
  
  static func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          completion(.failure(error))
          return
        }
        guard let data = data else { return }
        completion(.success(data))
      }
    }.resume()
  }
}
