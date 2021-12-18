//
//  FavoriteViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 08/02/21.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate {
    
    let viewModelFavorite = ViewModelFavorite.sharedViewModelFavorite
    var collectionView: UICollectionView?
    var placeholder: UILabel?
    let impact = UIImpactFeedbackGenerator()
    
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
        placeholder = favoriteView.placeholder
        self.view = favoriteView
        overrideUserInterfaceStyle = .light
    }
    
    func getData() {
        viewModelFavorite.favoriteFacts = viewModelFavorite.getAll()
        self.collectionView?.reloadData()
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModelFavorite.favoriteFacts?.count == 0 {
            placeholder?.isHidden = false
        } else {
            placeholder?.isHidden = true
        }
        return viewModelFavorite.favoriteFacts?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        guard let favoriteCell  = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.id, for: indexPath) as? FavoriteCell else { fatalError() }
        
        favoriteCell.delegateFavorite = self
        favoriteCell.cardLabel.text = viewModelFavorite.favoriteFacts?[indexPath.item  ].favoriteText
        favoriteCell.buttonFavorite.setImage(UIImage(named: "heartFill"), for: .normal)
        favoriteCell.buttonFavorite.tag = indexPath.row
        return favoriteCell
        
    }
}

extension FavoriteViewController: FavoriteButtonActionDelegate {
    func favoriteButtonAction(button: UIButton) {
        impact.impactOccurred()
        let favoriteFacts = viewModelFavorite.favoriteFacts
        guard let id = favoriteFacts?[button.tag].id else {return}
        if favoriteFacts?[button.tag].favoriteText == ViewModelFact.sharedViewModelFact.fact?.fact {
            ViewModelFact.sharedViewModelFact.isFavorite = false
        }
        viewModelFavorite.deleteItem(id:id)
        getData()
        collectionView?.reloadData()
    }
}


