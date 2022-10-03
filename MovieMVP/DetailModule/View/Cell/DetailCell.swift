//
//  DetailCollectionViewCell.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 27.08.2022.
//

import UIKit

class DetailCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: -  Properties
  
  let actorImage = UIImageView()
  let actorRealName = UILabel()
  let actorRole = UILabel()
  
//  override func prepareForReuse() {
//    super.prepareForReuse()
//    actorImage.image = nil
//    actorRealName.text = nil
//    actorRole.text = nil
//  }
  
  //MARK: - Actions
  private func configureCell() {
    addSubview(actorImage)
    addSubview(actorRealName)
    addSubview(actorRole)
    
    actorImage.translatesAutoresizingMaskIntoConstraints = false
    actorImage.layer.cornerRadius = actorImage.frame.width / 2
    actorImage.image = UIImage(systemName: "person")
    actorImage.layer.cornerRadius = actorImage.bounds.width / 2
    actorImage.clipsToBounds = true
    actorImage.contentMode = .scaleAspectFill
    
    actorRealName.text = "Some actor"
    actorRealName.textAlignment = .center
    actorRealName.numberOfLines = 0
    actorRealName.textColor = .white
    actorRealName.translatesAutoresizingMaskIntoConstraints = false
    actorRealName.font = UIFont.preferredFont(forTextStyle: .caption1)
    
    actorRole.translatesAutoresizingMaskIntoConstraints = false
    actorRole.text = "His role"
    actorRole.numberOfLines = 0
    actorRole.textAlignment = .center
    actorRole.textColor = .white
    actorRole.textAlignment = .center
    actorRole.font = UIFont.preferredFont(forTextStyle: .caption2)
    
    NSLayoutConstraint.activate([
      actorImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      actorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      actorImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      actorImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      
      actorRealName.topAnchor.constraint(equalTo: bottomAnchor, constant: 10),
      actorRealName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      actorRealName.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      actorRole.topAnchor.constraint(equalTo: actorRealName.bottomAnchor, constant: 5),
      actorRole.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      actorRole.centerXAnchor.constraint(equalTo: centerXAnchor)])
  }
}

