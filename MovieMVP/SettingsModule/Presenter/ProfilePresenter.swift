//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import Foundation
protocol ProfileViewProtocol: AnyObject {
  func nigntModeOn()
  func nigntModeOff()
}

protocol ProfileViewPresenterProtocol: AnyObject {
  init(view: ProfileViewProtocol)
  func turnNightModeOn()
  func turnNightModeOff()
}

class ProfilePresenter: ProfileViewPresenterProtocol {
  
  weak var view: ProfileViewProtocol?
  
  required init(view: ProfileViewProtocol) {
    self.view = view
  }
  
  func turnNightModeOn() {
    print("turnNightModeOn")
    view?.nigntModeOn()
  }
  
  func turnNightModeOff() {
    print("turnNightModeOff")
    view?.nigntModeOff()
  }
  
  
}

