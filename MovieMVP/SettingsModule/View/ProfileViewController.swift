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
 
  
}
//MARK: - Setup

private extension ProfileViewController {
  func setup() {
    setupViews()
    setConstraints()
  }
  private func setupViews() {
    view.backgroundColor = .specialBackground
  }
  private func setConstraints() {
    NSLayoutConstraint.activate([])
  }
}
//MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
  func success() {
    print("FAFA")
  }
  
  func failure(error: Error) {
    print(error.localizedDescription)
  }
  
  
}
