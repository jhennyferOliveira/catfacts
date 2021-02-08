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
    
    lazy var cardLabel: UILabel = {
        let cardLabel = UILabel()
        cardLabel.text = "Polydactyl cats (a cat with 1-2 extra toes on their paws) have this as a result of a genetic mutation. These cats are also referred to as 'Hemingway cats' because writer Ernest Hemingway reportedly owned dozens of them at his home in Key West, Florida."
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
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .large)
//        buttonFavorite.setImage(UIImage(systemName: "heart.fill", withConfiguration: imageConfig)?.withTintColor(.redAction, renderingMode: .alwaysOriginal), for: .normal)
//        buttonFavorite.target(forAction: <#T##Selector#>, withSender: <#T##Any?#>)
        buttonFavorite.setImage(UIImage(named: "heartEmpty")?.withTintColor(.redAction, renderingMode: .alwaysOriginal), for: .normal)
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
            buttonFavorite.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
//            buttonFavorite.widthAnchor.constraint(equalToConstant: 50),
//            buttonFavorite.heightAnchor.constraint(equalToConstant: 50)
            
        
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        buttonFavorite.contentMode = .scaleAspectFit
        setUpConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
