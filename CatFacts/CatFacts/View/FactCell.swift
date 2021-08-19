//
//  FactCell.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 06/02/21.
//

import Foundation
import UIKit

protocol FavoriteButtonActionDelegateToFactController {
    func updateFavoriteButtonState(button: UIButton)
}

protocol FavoriteButtonActionDelegateToFavoriteController {
    func removeFavoritedFactFromFavoriteView(button: UIButton)
}

class FactCell: UICollectionViewCell {       
    
    var delegateFactController: FavoriteButtonActionDelegateToFactController?
    var delegateFavoriteController: FavoriteButtonActionDelegateToFavoriteController?
    static let identifier = "factCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cornerRadiusValue: CGFloat = 20
        self.layer.cornerRadius = cornerRadiusValue
        self.backgroundColor = .white
        setUpViewHierarchy()
        setFactConstraints()
        setFavoriteConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var fact: UILabel = {
        let cardLabel = UILabel()
        cardLabel.font = UIFont.vartaRegular
        cardLabel.numberOfLines = 10
        cardLabel.textAlignment = .justified
        cardLabel.numberOfLines = 20
        cardLabel.font = cardLabel.font.withSize(17)
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        return cardLabel
    }()
    
    lazy var favorite: UIButton = {
        let buttonFavorite = UIButton()
        buttonFavorite.setImage(UIImage(named: "heartEmpty")?.withTintColor(.redAction, renderingMode: .alwaysOriginal), for: .normal)
        buttonFavorite .addTarget(self, action: #selector(delegateFavoriteActionToFactController), for: .touchUpInside)
        buttonFavorite .addTarget(self, action: #selector(delegateFavoriteActionToFavoriteController), for: .touchUpInside)
        buttonFavorite.contentMode = .scaleAspectFit
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
        return buttonFavorite
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(fact)
        self.addSubview(favorite)
    }
    
    func setFactConstraints() {
        NSLayoutConstraint.activate([
            fact.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            fact.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 23),
            fact.heightAnchor.constraint(equalToConstant: 190),
            fact.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -23)
        ])
    }
    
    func setFavoriteConstraints() {
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: fact.bottomAnchor),
            favorite.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 284),
            favorite.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
    
    @objc func delegateFavoriteActionToFactController(button: UIButton) {
        delegateFactController?.updateFavoriteButtonState(button: favorite)
    }
    
    @objc func delegateFavoriteActionToFavoriteController(button: UIButton) {
        delegateFavoriteController?.removeFavoritedFactFromFavoriteView(button: favorite)
    }
    
}
