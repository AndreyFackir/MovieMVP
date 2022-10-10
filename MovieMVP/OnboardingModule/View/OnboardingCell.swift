//
//  OnboardingCell.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 04.10.2022.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Properties
  private let topLabel: UILabel = {
    let element = UILabel()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.text = "Watch favourites movies and TVShows"
    element.font = .robotoMedium20
    element.textAlignment = .center
    element.textColor = .white
    return element
  }()
  
  private let image: UIImageView = {
    let element = UIImageView()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.image = UIImage(named: "first")
    element.contentMode = .scaleAspectFit
    return element
  }()
  
  private let bottomLabel: UILabel = {
      let element = UILabel()
      element.translatesAutoresizingMaskIntoConstraints = false
      element.text = "Only newest releases"
      element.textColor = .white
    element.font = .robotoMedium15
      element.textAlignment = .center
      return element
  }()
  
  //MARK: - Action
  func cellConfigure(model: OnboardingModel) {
    topLabel.text = model.topInfoLabel
    bottomLabel.text = model.description
    image.image = model.image
  }
}

extension OnboardingCell {
  private func setup() {
    setupViews()
    setConstraints()
  }
  
  private func setupViews() {
    backgroundColor = .black
    addSubview(image)
    addSubview(topLabel)
    addSubview(bottomLabel)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
     
      image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
          image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
          image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
          image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
       
          
          topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
          topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
          topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      
          bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
          bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
          bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
          bottomLabel.heightAnchor.constraint(equalToConstant: 85)])
  }
}
