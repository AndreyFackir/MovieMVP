//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import Foundation

protocol FavouritesViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}

protocol FavouritesViewPresenterProtocol: AnyObject {
  init(view: FavouritesViewProtocol, networkDataFetch: NetworkDataFetcherProtocol)
  
}

class FavouritesPresenter: FavouritesViewPresenterProtocol {
  weak var view: FavouritesViewProtocol?
  let networkDataFetch: NetworkDataFetcherProtocol
  
  required init(view: FavouritesViewProtocol, networkDataFetch: NetworkDataFetcherProtocol) {
    self.view = view
    self.networkDataFetch = networkDataFetch
  }
}

