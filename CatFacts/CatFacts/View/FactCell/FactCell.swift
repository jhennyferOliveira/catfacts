//
//  FactCell.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 06/02/21.
//

import Foundation
import UIKit

class FactCell: UICollectionViewCell {
    static let identifier = "factCell"
    var isFavorited = false
    lazy var cardLabel: UILabel = {
        let cardLabel = UILabel()
        cardLabel.font = UIFont.vartaRegular
        cardLabel.numberOfLines = 10
        cardLabel.textAlignment = .justified
        cardLabel.numberOfLines = 20
        cardLabel.font = cardLabel.font.withSize(17)
        cardLabel.translatesAutoresizingMaskIntoConstraints = false
        return cardLabel
    }()
    
    lazy var buttonFavorite: UIButton = {
        let buttonFavorite = UIButton()
        buttonFavorite.addTarget(self, action: #selector(buttonFavTouchUpInside), for: .touchUpInside)
        buttonFavorite.setImage(UIImage(named: "heartEmpty")?.withTintColor(.redAction, renderingMode: .alwaysOriginal), for: .normal)
        buttonFavorite.contentMode = .scaleAspectFit
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
    
        return buttonFavorite
    }()
    
    func setUpConstraints() {
        self.addSubview(cardLabel)
        self.addSubview(buttonFavorite)
        
        NSLayoutConstraint.activate([
            cardLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cardLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 23),
            cardLabel.heightAnchor.constraint(equalToConstant: 190),
            cardLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -23),
            
            buttonFavorite.topAnchor.constraint(equalTo: cardLabel.bottomAnchor),
            buttonFavorite.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 284),
            buttonFavorite.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
    

        ])
    }
    
    @objc func buttonFavTouchUpInside(button: UIButton) {
        self.isFavorited = !self.isFavorited
        updateFavButton(isFavorite: self.isFavorited, button: button)
        
    }
    
    func updateFavButton(isFavorite: Bool, button: UIButton) {
            if isFavorite {
                button.setImage(UIImage(named: "heartFill"), for: .normal)
                // save with core data
                
            } else {
                button.setImage(UIImage(named: "heartEmpty"), for: .normal)
                // delete core data
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.backgroundColor = .white
        buttonFavorite.contentMode = .scaleAspectFit
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
