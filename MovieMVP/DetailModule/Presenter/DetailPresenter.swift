//
//  DetailPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 27.08.2022.
//

import UIKit
import RealmSwift

protocol DetailViewProtocol: AnyObject {
  func setDetails(movie: Movies?, serial: TVShows?)
  func success()
  func failure(error: Error)
  func saveToFavourites()
  func deleteFromFavourites()
  func databaseRequest()
}

protocol DetailViewPresenterProtocol: AnyObject {
  init(view: DetailViewProtocol, networkDataFetch: NetworkDataFetcherProtocol, movie: Movies?, serial: TVShows?)
  var serialAndMovieCast: SerialAndMoviesCast? { get set }
  var movie: Movies? { get }
  var serial: TVShows? { get }
  var isFavourite: Bool { get set }
  func setDetails()
  func getImage(from url: String, completion: @escaping(UIImage) -> Void)
  func setCast()
  func saveToFavourites()
  func fetch() -> Results<Favourites>
}

final class DetailPresenter: DetailViewPresenterProtocol {
  
  weak var view: DetailViewProtocol?
  let networkDataFetch: NetworkDataFetcherProtocol
  var movie: Movies?
  var serial: TVShows?
  var serialAndMovieCast: SerialAndMoviesCast?
  let database = try! Realm()
  var isFavourite = false
  
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
  
  func getSerialAndMovieString() -> String {
    if movie == nil {
      guard let imageUrl = serial?.posterPath else { return ""}
      let fullImageUrl = Constants.posterUrl + imageUrl
      return fullImageUrl
    } else {
      guard let imageUrl = movie?.posterPath else { return "" }
      let fullImageUrl = Constants.posterUrl + imageUrl
      return fullImageUrl
    }
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
  
  func fetch() -> Results<Favourites> {
    database.objects(Favourites.self)
  }
  
  func saveToFavourites() {
    let favourites = Favourites()
    
    if movie == nil {
      favourites.id = serial?.id ?? 0
      favourites.favouriteMovieImageUrl = getSerialAndMovieString()
    } else {
      favourites.id = movie?.id ?? 0
      favourites.favouriteMovieImageUrl = getSerialAndMovieString()
    }
    
    if !isFavourite {
      favourites.isFavourite = true
      save(object: favourites)
      print("saved")
      view?.saveToFavourites()
    } else {
      favourites.isFavourite = false
      delete(id: favourites.id)
      print("Object was deleted")
      view?.deleteFromFavourites()
    }
    isFavourite = !isFavourite
  }
  
  func save(object: Favourites, _ errorHandler: @escaping ((_ error: Swift.Error) -> Void) = { _ in return }) {
    let results = fetch()
    guard !results.contains(where: {$0.id == object.id}) else {
      update(object: object, errorHandler: errorHandler)
      return
    }
    do {
      try database.write({
        database.add(object)
      })
    } catch {
      errorHandler(error)
    }
  }
  
  func update(object: Favourites, errorHandler: @escaping ((_ error: Swift.Error) -> Void) = { _ in return }) {
    do {
      try database.write({
        database.add(object, update: .modified)
      })
    } catch {
      errorHandler(error)
    }
  }
  
  func delete(id: Int, errorHandler: @escaping ((_ error: Swift.Error) -> Void) = { _ in return }) {
    guard let object = database.object(ofType: Favourites.self, forPrimaryKey: id) else { return }
    do {
      try database.write({
        database.delete(object)
      })
    } catch {
      errorHandler(error)
    }
  }
}
