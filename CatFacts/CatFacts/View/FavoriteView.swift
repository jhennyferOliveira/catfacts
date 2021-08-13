//
//  FavoriteView.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    var controller : FavoriteViewController?
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(FactCell.self, forCellWithReuseIdentifier: FactCell.identifier)
        collectionView.backgroundColor = .yellowPrimary
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    lazy var placeholder: UILabel = {
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
    
    
    func setUpConstraints() {
        self.addSubview(collectionView)
        self.addSubview(placeholder)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            placeholder.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            placeholder.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            placeholder.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        self.backgroundColor = .yellowPrimary

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoriteView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(
            top: 46,
            left: 0,
            bottom: 16,
            right: 0)
        flowLayout.itemSize = CGSize(width: 336, height: 242)
        return flowLayout
    }
    
}
