//
//  FavCell.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/02/21.
//

import Foundation
import UIKit

protocol FavoriteButtonActionDelegate {
    func favoriteButtonAction(button: UIButton)
}

class FavoriteCell: FactCell {
    static let id = "fav"
    var delegateFavorite: FavoriteButtonActionDelegate?
    override func buttonFavTouchUpInside(button: UIButton) {
        delegateFavorite?.favoriteButtonAction(button: buttonFavorite)
    }
   
    
}
