//
//  GalleryOrFotoAllert.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 09.10.2022.
//

import Foundation
import UIKit

extension UIViewController {
  func alertFotoCamera(completion: @escaping (UIImagePickerController.SourceType) -> Void) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let camera = UIAlertAction(title: "Camera", style: .default) { _ in
      let camera = UIImagePickerController.SourceType.camera
      completion(camera)
    }
    let photoLibrary = UIAlertAction(title: "Library", style: .default) { _ in
      let library = UIImagePickerController.SourceType.photoLibrary
      completion(library)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .default)
    alertController.addAction(camera)
    alertController.addAction(photoLibrary)
    alertController.addAction(cancel)
    present(alertController, animated: true, completion: nil)
  }
}
