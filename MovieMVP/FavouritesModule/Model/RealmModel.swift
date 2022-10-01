//
//  RealmModel.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 29.09.2022.
//

import Foundation
import RealmSwift

final class Favourites: Object {
  @Persisted var favouriteMovieImageUrl = ""
  @Persisted var isFavourite = false
  @Persisted(primaryKey: true) var id = 0
}
