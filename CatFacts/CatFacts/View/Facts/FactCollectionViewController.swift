//
//  FactCollectionViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 07/02/21.
//

import Foundation
import UIKit
import CoreData

class FactCollectionViewController: UIViewController {
    
    private let viewModelFact = ViewModelFact()
    private let viewModelFavorite = ViewModelFavorite()
    var button: UIButton?
    var favorite: Favorite?
    var collectionView: UICollectionView?
    var factCell: FactCell?
    let coreData = CoreDataFunctions()
    
    override func loadView() {
        let factView = FactsView()
        factView.card.delegate = self
        factView.card.dataSource = self
        factView.controller = self
        self.collectionView = factView.card
        self.button = factView.buttonNewFact
        button?.addTarget(self, action: #selector(newFactButton), for: .touchUpInside)
        self.view = factView
        getData()
    }
    
    
    @objc func newFactButton() {
        getData()
    }
    
    func getData() {
        viewModelFact.getFact { fact in
            DispatchQueue.main.async {
                self.viewModelFact.fact = fact
                // reload when fact gets the value
                self.collectionView?.reloadData()
            }
        }
    }
}

extension FactCollectionViewController: FavoriteButtonActionsDelegate {
    
    func favButtonAction(button: UIButton) {
        viewModelFavorite.isFavorite = !viewModelFavorite.isFavorite
        updateFavButton(isFavorite: viewModelFavorite.isFavorite, button: button)
    }

    func updateFavButton(isFavorite: Bool, button: UIButton) {
        if viewModelFavorite.isFavorite {
            
            button.setImage(UIImage(named: "heartFill"), for: .normal)
            
            guard let fact = viewModelFact.fact else {return}
            viewModelFact.save(fact: fact )


        } else {
            
            button.setImage(UIImage(named: "heartEmpty"), for: .normal)
            guard let fact = viewModelFact.fact else {return}
            
            let favoriteFacts = viewModelFavorite.getAll()
            
            for favorite in favoriteFacts{
                if favorite.favoriteText == fact.fact {
                    print(viewModelFavorite.getAll().count)
                    guard let id = favorite.id else {return}
                    viewModelFavorite.deleteItem(id: id)
                    print(viewModelFavorite.getAll().count)
                }
            }
            
        }
    }
}



extension FactCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let factCell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath) as? FactCell else {
            fatalError();
        }
        
        factCell.cardLabel.text = viewModelFact.fact?.fact
        factCell.buttonFavorite.setImage(UIImage(named: "heartEmpty"), for: .normal)
        factCell.delegate = self
        
        return factCell
    }
    
    
}
