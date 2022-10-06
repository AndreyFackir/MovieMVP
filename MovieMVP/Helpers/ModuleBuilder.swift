//
//  ModuleBuilder.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//


import UIKit

protocol Builder {
  static func createTabBar() -> UITabBarController
  static func createMainModule() -> UIViewController
  static func createDetailModule(with movie: Movies?) -> UIViewController
  static func createDetailModule(with serial: TVShows?) -> UIViewController
  static func createFavouritesModule() -> UIViewController
  static func createProfileModule() -> UIViewController
  static func createWebViewModule(movie: Movies?, serial: TVShows?) -> UIViewController
  static func createOnboardingModule() -> UIViewController
}

class ModuleBuilder: Builder {
  
  static func createTabBar() -> UITabBarController {
    let view = MainTabbarViewController()
    return view
  }
 
  static func createMainModule() -> UIViewController {
    let view = MainViewController()
    let netWorkDataFetcher = NetworkDataFetcher()
    let presenter = MainPresenter(view: view, networkDataFetch: netWorkDataFetcher)
    view.presenter = presenter
    return view
  }
  
  static func createDetailModule(with movie: Movies?) -> UIViewController {
    let view = DetailViewController()
    let networkDataFetcher = NetworkDataFetcher()
    let presenter = DetailPresenter(view: view, networkDataFetch: networkDataFetcher, movie: movie, serial: nil)
    view.presenter = presenter
    return view
  }
  
  static func createDetailModule(with serial: TVShows?) -> UIViewController {
    let view = DetailViewController()
    let networkDataFetcher = NetworkDataFetcher()
    let presenter = DetailPresenter(view: view, networkDataFetch: networkDataFetcher, movie: nil, serial: serial)
    view.presenter = presenter
    return view
  }
  
  static func createFavouritesModule() -> UIViewController {
    let view = FavouriteViewController()
    let networkDataFetcher = NetworkDataFetcher()
    let presenter = FavouritesPresenter(view: view, networkDataFetch: networkDataFetcher)
    view.presenter = presenter
    return view
  }
  
  static func createProfileModule() -> UIViewController {
    let view = ProfileViewController()
    let presenter = ProfilePresenter(view: view)
    view.presenter = presenter
    return view
  }
  
  static func createWebViewModule(movie: Movies?, serial: TVShows?) -> UIViewController {
    let view = WebViewViewController()
    let presenter = WebViewPresenter(view: view, movie: movie, serial: serial)
    view.presenter = presenter
    return view
  }
  
  static func createOnboardingModule() -> UIViewController {
    let view = OnboardingViewController()
    let presenter = OnboardingPresenter(view: view)
    view.presenter = presenter
    return view
  }
  
}
