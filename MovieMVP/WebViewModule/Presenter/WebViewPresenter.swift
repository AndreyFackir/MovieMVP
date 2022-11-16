//
//  WebViewPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 26.09.2022.
//

import Foundation

//MARK: - Protocols
protocol WebViewProtocol: AnyObject {
  func makeRequest(with url: String)
}

protocol WebViewPresenterProtocol: AnyObject {
  init(view: WebViewProtocol, movie: Movies?, serial: TVShows?)
  func makeRequest()
}

//MARK: - WebViewPresenter
final class WebViewPresenter: WebViewPresenterProtocol {
  
  weak var view: WebViewProtocol?
  var movie: Movies?
  var serial: TVShows?
  
  required init(view: WebViewProtocol, movie: Movies?, serial: TVShows?) {
    self.view = view
    self.movie = movie
    self.serial = serial
  }
  
  func makeRequest()  {
    var webUrl = ""
    if movie == nil {
      webUrl = "https://www.themoviedb.org/tv/\(serial?.id ?? 0)/watch"
    } else {
      webUrl = "https://www.themoviedb.org/movie/\(movie?.id ?? 0)/watch"
    }
    view?.makeRequest(with: webUrl)
  }
}
