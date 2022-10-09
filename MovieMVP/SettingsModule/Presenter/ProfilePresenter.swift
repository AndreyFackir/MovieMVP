//
//  FavouritesPresenter.swift
//  MovieMVP
//
//  Created by Андрей Яфаркин on 12.09.2022.
//

import Foundation
protocol ProfileViewProtocol: AnyObject {
    
}

protocol ProfileViewPresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
    
}

class ProfilePresenter: ProfileViewPresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func saveUserDefaults() {
        
    }
    
    
}

