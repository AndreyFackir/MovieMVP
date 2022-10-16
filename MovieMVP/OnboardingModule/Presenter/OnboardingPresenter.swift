//
//  OnboardingPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 05.10.2022.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
  func nextButtontapped()
  func setPageControlCurrentPage(index: IndexPath, collectionItem: Int)
  func dismissVC()
}

protocol OnboardingViewPresenterProtocol: AnyObject {
  init(view: OnboardingViewProtocol)
  func nextButtontapped()
  func configureScreens() -> [OnboardingModel]
}

class OnboardingPresenter: OnboardingViewPresenterProtocol {
  
  weak var view: OnboardingViewProtocol?
  var onboardingModel: OnboardingModel?
  var collectionItem = 0
  
  required init(view: OnboardingViewProtocol) {
    self.view = view
  }
  
  func nextButtontapped() {
    if collectionItem == 1{
      view?.nextButtontapped()
    }
    if collectionItem == 2 {
      saveUserDefaults()
    } else {
      collectionItem += 1
      let index:IndexPath = [0, collectionItem]
      view?.setPageControlCurrentPage(index: index, collectionItem: collectionItem)
    }
  }
  
  func saveUserDefaults() {
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: "OnboardingWasViewed")
    if userDefaults.bool(forKey: "OnboardingWasViewed"){
      view?.dismissVC()
    }
  }
  
  func configureScreens() -> [OnboardingModel] {
    var onboardingArray = [OnboardingModel]()
    guard let firstImage = UIImage(named: "first"),
          let seondImage = UIImage(named: "second"),
          let thirdImage = UIImage(named: "third") else { return .init() }
    let firstScreen = OnboardingModel(topInfoLabel: "Be first to watch movies and TVShows",
                                      description: "Only newest releases",
                                      image: firstImage)
    let secondScreen = OnboardingModel(topInfoLabel: "Add to favourites",
                                       description: "Favourites movies and TVShows will always be at hand ",
                                       image: seondImage)
    let thirdScreen = OnboardingModel(topInfoLabel: "Have fun",
                                      description: "Let's go",
                                      image: thirdImage)
    onboardingArray = [firstScreen, secondScreen, thirdScreen]
    return onboardingArray
  }
}
