//
//  UILabel.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 09.10.2022.
//

import Foundation
import UIKit

extension UILabel {
  convenience init(_ text: String = "") {
    self.init()
    self.text = text
    self.self.font = .robotoMedium12
    self.textColor = .specilaLightBrown
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}
