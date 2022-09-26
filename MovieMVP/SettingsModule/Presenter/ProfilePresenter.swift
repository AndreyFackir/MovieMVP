//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import Foundation
protocol ProfileViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}

protocol ProfileViewPresenterProtocol: AnyObject {
  init(view: ProfileViewProtocol, networkDataFetch: NetworkDataFetcherProtocol)
  
}

class ProfilePresenter: ProfileViewPresenterProtocol {
  weak var view: ProfileViewProtocol?
  let networkDataFetch: NetworkDataFetcherProtocol
  
  required init(view: ProfileViewProtocol, networkDataFetch: NetworkDataFetcherProtocol) {
    self.view = view
    self.networkDataFetch = networkDataFetch
  }
}

