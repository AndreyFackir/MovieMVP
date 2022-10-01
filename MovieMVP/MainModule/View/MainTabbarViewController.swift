//
//  MainTabbarViewController.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit

class MainTabbarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupItems()
  }
  
  private func setupTabBar() {
    let layer = CAShapeLayer()
    let positionX: CGFloat = 10
    let positionY: CGFloat = 20
    layer.path = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY,
                                                  width: tabBar.bounds.width - positionX * 2,
                                                  height: tabBar.bounds.height + positionY * 2),
                                                  cornerRadius: (tabBar.frame.width / 2)).cgPath
    layer.shadowColor = UIColor.lightGray.cgColor
    layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
    layer.shadowRadius = 25
    layer.shadowOpacity = 0.3
    layer.borderWidth = 1
    layer.opacity = 1
    layer.isHidden = false
    layer.masksToBounds = false
    layer.fillColor = UIColor.specialTabBar.cgColor
    
    tabBar.layer.insertSublayer(layer, at: 0)
    tabBar.barTintColor = .clear
    tabBar.itemWidth = (tabBar.bounds.width - positionY * 2) / 5
    tabBar.itemPositioning = .fill
    tabBar.unselectedItemTintColor = .white
    tabBar.isTranslucent = true
  }
  
  private func setupItems() {
    let mainVC = UINavigationController(rootViewController: ModuleBuilder.createMainModule())
    let preofileVC = UINavigationController(rootViewController: ModuleBuilder.createProfileModule())
    let favouriteVC = UINavigationController(rootViewController: ModuleBuilder.createFavouritesModule())
    setViewControllers([mainVC, favouriteVC, preofileVC], animated: true)
    
    guard let items = tabBar.items else { return }
   
    items[0].title = "Main"
    items[1].title = "Favourites"
    items[2].title = "Settings"
    items[0].image = UIImage(systemName: "house.fill")
    items[1].image = UIImage(systemName: "heart.fill")
    items[2].image = UIImage(systemName: "person.fill")
    
    UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    let attrs = [
      NSAttributedString.Key.foregroundColor: UIColor.white,
      NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 24)!]
    UINavigationBar.appearance().titleTextAttributes = attrs
  }
}
