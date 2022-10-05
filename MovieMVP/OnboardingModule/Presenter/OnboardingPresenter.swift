//
//  OnboardingPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 05.10.2022.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
  func nextButtontapped()
}

protocol OnboardingViewPresenterProtocol: AnyObject {
  init(view: OnboardingViewProtocol, onboardingModel: OnboardingModel? )
  func nextButtontapped()
  func saveUserDefaults()
  var onboardingModel: OnboardingModel? { get set }
}

class OnboardingPresenter: OnboardingViewPresenterProtocol {
  
  weak var view: OnboardingViewProtocol?
  var onboardingModel: OnboardingModel?
  required init(view: OnboardingViewProtocol, onboardingModel: OnboardingModel?) {
    self.view = view
    self.onboardingModel = onboardingModel
  }
  
  func nextButtontapped() {
    print("nextButtontapped")
  }
  
  func saveUserDefaults() {
    print("saveUserDefaults")
  }
  
  
}
