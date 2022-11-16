//
//  MainCollectionViewCell.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Properties
  let imageView = UIImageView()
  let footerLabel = UILabel()
  let dateOfReleaseLabel = UILabel()
  let savedImage = UIImageView()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    footerLabel.text = nil
    dateOfReleaseLabel.text = nil
  }
  
  //MARK: - Actions
  private func configure() {
    addSubview(imageView)
    addSubview(footerLabel)
    addSubview(dateOfReleaseLabel)
    addSubview(savedImage)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 15
    imageView.layer.masksToBounds = true
    imageView.image = UIImage(systemName: "film.stack")
    
    savedImage.translatesAutoresizingMaskIntoConstraints = false
    savedImage.image = UIImage(systemName: "heart")
    savedImage.tintColor = .white
    
    footerLabel.text = "Some footer"
    footerLabel.textColor = .white
    footerLabel.translatesAutoresizingMaskIntoConstraints = false
    footerLabel.font = UIFont.preferredFont(forTextStyle: .body)
    
    dateOfReleaseLabel.text = "Des 16,2020"
    dateOfReleaseLabel.textColor = .specialDesription
    dateOfReleaseLabel.translatesAutoresizingMaskIntoConstraints = false
    dateOfReleaseLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: widthAnchor),
      imageView.heightAnchor.constraint(equalTo: heightAnchor),
      
      savedImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
      savedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
      
      footerLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      footerLabel.widthAnchor.constraint(equalTo: widthAnchor),
      
      dateOfReleaseLabel.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 5),
      dateOfReleaseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)])
  }
}

