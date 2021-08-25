//
//  FavoriteViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 08/02/21.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate {
    
    let viewModelFavorite = ViewModelFavorite.sharedInstance
    var collectionView: UICollectionView?
    var placeholderForEmptyScreen: UILabel?
    let impactFeedbackForFavoriteButton = UIImpactFeedbackGenerator()
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoritedFacts()
    }
    
    override func loadView() {
        super.loadView()
        let favoriteView = FavoriteView()
        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self
        favoriteView.controller = self
        collectionView = favoriteView.collectionView
        placeholderForEmptyScreen = favoriteView.placeholderNoFavoritedFacts
        self.view = favoriteView
        overrideUserInterfaceStyle = .light
    }
    
    func getFavoritedFacts() {
        viewModelFavorite.favoritedFacts = viewModelFavorite.getAll()
        self.collectionView?.reloadData()
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModelFavorite.favoritedFacts?.count == 0 {
            placeholderForEmptyScreen?.isHidden = false
        } else {
            placeholderForEmptyScreen?.isHidden = true
        }
        return viewModelFavorite.favoritedFacts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let factCell  = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath) as? FactCell else { fatalError() }
        
        factCell.delegateFavoriteController = self
        factCell.fact.text = viewModelFavorite.favoritedFacts?[indexPath.item  ].favoriteText
        factCell.favorite.setImage(UIImage(named: "heartFill"), for: .normal)
        factCell.favorite.tag = indexPath.row
        return factCell
    }
}

extension FavoriteViewController: FavoriteButtonActionDelegateToFavoriteController {

    func removeFavoritedFactFromFavoriteView(button: UIButton) {
        impactFeedbackForFavoriteButton.impactOccurred()
        viewModelFavorite.currentFactIsFavorite = !viewModelFavorite.currentFactIsFavorite
        let favoriteFacts = viewModelFavorite.favoritedFacts
        guard let idFavoritedFactToBeRemoved = favoriteFacts?[button.tag].id else {return}
        viewModelFavorite.deleteItem(id:idFavoritedFactToBeRemoved)
        getFavoritedFacts()
        collectionView?.reloadData()
    }
}


