//
//  FavoriteView.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    var controller: FavoriteViewController?
    var viewBackgroundColor: UIColor = .yellowPrimary
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewHierarchy()
        setCollectionViewConstraints()
        setPlaceholderConstraints()
        self.backgroundColor = viewBackgroundColor

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        collectionView.register(FactCell.self, forCellWithReuseIdentifier: FactCell.identifier)
        collectionView.backgroundColor = .yellowPrimary
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var placeholderNoFavoritedFacts: UILabel = {
        let placeholder = UILabel()
        placeholder.font = UIFont.vartaRegular
        placeholder.text = "Favorite a fact and it will be shown here"
        placeholder.numberOfLines = 10
        placeholder.textColor = .purpleAction
        placeholder.textAlignment = .center
        placeholder.numberOfLines = 20
        placeholder.font = placeholder.font.withSize(23)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(collectionView)
        self.addSubview(placeholderNoFavoritedFacts)
    }
    
    func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderNoFavoritedFacts.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            placeholderNoFavoritedFacts.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholderNoFavoritedFacts.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension FavoriteView {
    
    private func setCollectionViewLayout() -> UICollectionViewLayout {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumLineSpacing = 16
        collectionLayout.scrollDirection = .vertical
        collectionLayout.sectionInset = UIEdgeInsets(
            top: 46,
            left: 0,
            bottom: 16,
            right: 0)
        collectionLayout.itemSize = CGSize(width: 336, height: 242)
        return collectionLayout
    }
    
}
