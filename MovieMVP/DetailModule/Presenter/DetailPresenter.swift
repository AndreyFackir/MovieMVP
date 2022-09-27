//
//  DetailPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 27.08.2022.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
  func setDetails(movie: Movies?, serial: TVShows?)
  func success()
  func failure(error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
  init(view: DetailViewProtocol, networkDataFetch: NetworkDataFetcherProtocol, movie: Movies?, serial: TVShows?)
  func setDetails()
  func getImage(from url: String, completion: @escaping(UIImage) -> Void)
  var serialAndMovieCast: SerialAndMoviesCast? { get set }
  func setCast()
  var movie: Movies? { get }
  var serial: TVShows? { get }
}

class DetailPresenter: DetailViewPresenterProtocol {
  
  weak var view: DetailViewProtocol?
  let networkDataFetch: NetworkDataFetcherProtocol
  var movie: Movies?
  var serial: TVShows?
  var serialAndMovieCast: SerialAndMoviesCast?
  
  
  required init(view: DetailViewProtocol, networkDataFetch: NetworkDataFetcherProtocol, movie: Movies?, serial: TVShows?) {
    self.view = view
    self.networkDataFetch = networkDataFetch
    self.movie = movie
    self.serial = serial
    setCast()
  }
  
  func setDetails() {
    self.view?.setDetails(movie: movie, serial: serial)
  }
  
  func getImage(from url: String, completion: @escaping(UIImage) -> Void) {
    guard let imageUrl = URL(string: url) else { return }
    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
      if let data = data, let image = UIImage(data: data) {
        DispatchQueue.main.async {
          completion(image)
        }
      }
    }.resume()
  }
  
  func setCast() {
    var castUrl = ""
    if movie == nil {
      castUrl =  "https://api.themoviedb.org/3/tv/\(serial?.id ?? 0)/credits?api_key=\(Constants.apiKey)"
    } else {
      castUrl =  "https://api.themoviedb.org/3/movie/\(movie?.id ?? 0)/credits?api_key=\(Constants.apiKey)"
    }
    
    networkDataFetch.fetchSerialAndMovieCast(url: castUrl) { [weak self] cast in
      guard let self = self else { return }
      self.serialAndMovieCast = cast
      self.view?.success()
    }
  }
  
  
  
}
