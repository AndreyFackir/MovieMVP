//
//  File.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import UIKit

class ProfileViewController: UIViewController {
  
  var presenter: ProfileViewPresenterProtocol!
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  //MARK: - Properties
  
  private let switchNightMode: UISwitch = {
    let element = UISwitch()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.isOn = false
    element.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
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
  
  //MARK: - Actions
  @objc private func switchValueChanged() {
    if switchNightMode.isOn {
      presenter.turnNightModeOn()
    } else {
      presenter.turnNightModeOff()
    }
  }
}
//MARK: - Setup

private extension ProfileViewController {
  func setup() {
    setupViews()
    setConstraints()
    setupNavBar()
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
  
  private func setupNavBar() {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .specialBackground
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.navigationBar.standardAppearance = coloredAppearance
    navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance
    navigationController?.navigationBar.tintColor = UIColor.white
  }
}
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
  func nigntModeOn() {
   print("on")
  }
  
  func nigntModeOff() {
    print("off")
  }
}
