//
//  File.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
  
  var presenter: ProfileViewPresenterProtocol!
  let userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    presenter.turnNightModeOn()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    switchNightMode.isOn = userDefaults.bool(forKey: "night")
  }
  
  //MARK: - Properties
  
  private let switchNightMode: UISwitch = {
    let element = UISwitch()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.isOn = false
    return element
  }()
  
  private let switchLabel: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "Night Mode"
    element.font = .specialFont
    element.textColor = .white
    return element
  }()
 
  
}
//MARK: - Setup

private extension ProfileViewController {
  func setup() {
    setupViews()
    setConstraints()
  }
  private func setupViews() {
    title = "Settings"
    view.backgroundColor = .specialBackground
    view.addSubview(switchLabel)
    view.addSubview(switchNightMode)
  }
  private func setConstraints() {
    NSLayoutConstraint.activate([
      switchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      switchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
    
      switchNightMode.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      switchNightMode.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)])
  }
}
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
  func nigntModeOn() {
    if switchNightMode.isOn {
      UserDefaults.standard.set(true, forKey: "night")
    } else {
      UserDefaults.standard.set(false, forKey: "night")
    }
  }
  
}
