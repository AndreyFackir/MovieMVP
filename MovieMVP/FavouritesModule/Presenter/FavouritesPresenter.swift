//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit
import RealmSwift

protocol FavouritesViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}

protocol FavouritesViewPresenterProtocol: AnyObject {
  init(view: FavouritesViewProtocol, networkDataFetch: NetworkDataFetcherProtocol)
  func showFavourites()
  func getImage(from url: String, completion: @escaping(UIImage) -> Void)
  func fetchFavourites() -> Results<Favourites>
}

class FavouritesPresenter: FavouritesViewPresenterProtocol {
  weak var view: FavouritesViewProtocol?
  let networkDataFetch: NetworkDataFetcherProtocol
  let database = try! Realm()
  
  
  required init(view: FavouritesViewProtocol, networkDataFetch: NetworkDataFetcherProtocol) {
    self.view = view
    self.networkDataFetch = networkDataFetch
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
  
  func fetchFavourites() -> Results<Favourites> {
    database.objects(Favourites.self)
  }
  
  func showFavourites()  {
    
    fetchFavourites()
    print("showFavourites")
    view?.success()
  }
}

