//
//  FavoriteViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 08/02/21.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate {
    
    let viewModelFavorite = ViewModelFavorite()
    
    var collectionView: UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    override func loadView() {
        super.loadView()
        let favoriteView = FavoriteView()
        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self
        favoriteView.controller = self
        collectionView = favoriteView.collectionView
        self.view = favoriteView
        
    }
    
    func getData() {
        viewModelFavorite.favoriteFacts = viewModelFavorite.getAll()
        self.collectionView?.reloadData()
    }
    
    
    
    
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModelFavorite.favoriteFacts?.count ?? 0
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let factCell  = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath) as? FactCell else { fatalError() }
        
        factCell.delegate = self
        factCell.cardLabel.text = viewModelFavorite.favoriteFacts?[indexPath.item  ].favoriteText
        factCell.buttonFavorite.setImage(UIImage(named: "heartFill"), for: .normal)
        factCell.buttonFavorite.tag = indexPath.row
        return factCell
        
    }
}

extension FavoriteViewController: FavoriteButtonActionsDelegate {
    func favButtonAction(button: UIButton) {
        viewModelFavorite.isFavorite = !viewModelFavorite.isFavorite
        let favoriteFacts = viewModelFavorite.favoriteFacts
        guard let id = favoriteFacts?[button.tag].id else {return}
        viewModelFavorite.deleteItem(id:id)
        collectionView?.reloadData()
             
 
    }
}


