//
//  MainPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//


import UIKit
import RealmSwift

protocol MainViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
  init(view: MainViewProtocol, networkDataFetch: NetworkDataFetcherProtocol)
  var movies: MovieModel? { get set }
  var serials: SerialModel? { get set }
  func getMovies()
  func getSerials()
  func convertedDateFormat(sourceString: String, sourceFormat: String, destinationFormat: String) -> String
  func getImage(from url: String, completion: @escaping(UIImage) -> Void)
  func fetch() -> Results<Favourites>
}

final class MainPresenter: MainViewPresenterProtocol {
  weak var view: MainViewProtocol?
  let netWorkDataFetch: NetworkDataFetcherProtocol
  var movies: MovieModel?
  var serials: SerialModel?
  let database = try! Realm()
 
  required init(view: MainViewProtocol, networkDataFetch: NetworkDataFetcherProtocol) {
    self.view = view
    self.netWorkDataFetch = networkDataFetch
    getMovies()
    getSerials()
  }
  
  func getMovies() {
    netWorkDataFetch.fetchDataMovies(url: Constants.movieString) { [weak self] movies in
      guard let self = self else { return }
      self.movies = movies
      self.view?.success()
    }
  }
  
  func getSerials() {
    netWorkDataFetch.fetchTVShows(url: Constants.serialString) { [weak self] serials in
      guard let self = self else { return }
      self.serials = serials
      self.view?.success()
    }
  }
  
  func convertedDateFormat(sourceString: String, sourceFormat: String, destinationFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = sourceFormat
    if let date = dateFormatter.date(from: sourceString) {
      dateFormatter.dateFormat = destinationFormat
      return dateFormatter.string(from: date)
    } else {
      return ""
    }
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
  
  func fetch() -> Results<Favourites> {
    database.objects(Favourites.self)
  }
}
