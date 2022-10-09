//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import Foundation
import UIKit
protocol ProfileViewProtocol: AnyObject {
  func addTapToChooseImage()
  func loadUserInfo()
}

protocol ProfileViewPresenterProtocol: AnyObject {
  init(view: ProfileViewProtocol)
  func saveButtonTapped(name: String, surname: String, image: Data)
  func addTapToChooseImage()
  func loadUserInfo()
}

class ProfilePresenter: ProfileViewPresenterProtocol {
  weak var view: ProfileViewProtocol?
  
  required init(view: ProfileViewProtocol) {
    self.view = view
  }
  
  func saveButtonTapped(name: String, surname: String, image: Data) {
    saveUserDefaults(name: name, surname: surname, image: image)
    print("saveButton tapped")
  }
  
  func saveUserDefaults(name: String, surname: String, image: Data) {
    let userDefaults = UserDefaults.standard
    userDefaults.set(name, forKey: "name")
    userDefaults.set(surname, forKey: "surname")
    userDefaults.set(image, forKey: "image")
  }
  
  func addTapToChooseImage() {
    view?.addTapToChooseImage()
  }
  
  func loadUserInfo() {
    view?.loadUserInfo()
  }
}

