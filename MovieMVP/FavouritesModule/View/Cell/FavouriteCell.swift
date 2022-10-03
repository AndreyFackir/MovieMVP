//
//  FavouriteCell.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 26.09.2022.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Properties
    let image: UIImageView = {
    let element = UIImageView()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.image = UIImage(systemName: "film.stack")
    element.layer.cornerRadius = 10
    element.layer.masksToBounds = true
    return element
  }()
  
  private let savedImage: UIImageView = {
    let element = UIImageView()
    element.translatesAutoresizingMaskIntoConstraints = false
    element.image = UIImage(systemName: "heart.fill")
    element.tintColor = .red
    return element
  }()
}

//MARK: - Setup
private extension FavouriteCell {
  private func setup() {
    setupViews()
    setConstraints()
  }
  
  private func setupViews() {
    layer.cornerRadius = 10
    addSubview(image)
    addSubview(savedImage)
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      image.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
    
      savedImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      savedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)])
  }
}
