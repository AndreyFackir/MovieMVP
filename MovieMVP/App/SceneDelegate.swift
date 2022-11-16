//
//  SceneDelegate.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    if UserDefaults.standard.bool(forKey: "OnboardingWasViewed") {
      window?.rootViewController = ModuleBuilder.createTabBar()
    } else {
      window?.rootViewController = ModuleBuilder.createOnboardingModule()

    }
    window?.makeKeyAndVisible()
  }


}

