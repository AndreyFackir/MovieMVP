//
//  TitleSupplementaryView.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 25.08.2022.
//

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
  
  let headerLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    headerLabel.frame = bounds
  }
  
  func configure() {
    addSubview(headerLabel)
    let inset = CGFloat(10)
    headerLabel.translatesAutoresizingMaskIntoConstraints = false
    headerLabel.adjustsFontForContentSizeCategory = true
    headerLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    headerLabel.textColor = .white
    
    NSLayoutConstraint.activate([
      headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
      headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
      headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
      headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)])
  }
}
