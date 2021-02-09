//
//  FactCollectionViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 07/02/21.
//

import Foundation
import UIKit

class FactCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    private let myViewModel = ViewModel()
    var button: UIButton?
    var collectionView: UICollectionView?

    
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
        myViewModel.getFact { fact in
            DispatchQueue.main.async {
                self.myViewModel.fact = fact
                // reload when fact gets the value
                self.collectionView?.reloadData()
            }
        }
    }
}



extension FactCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath)
        
        if let cell = cell as? FactCell {
            cell.cardLabel.text = myViewModel.fact?.fact
        }
        
        return cell
    }
    
    
}
