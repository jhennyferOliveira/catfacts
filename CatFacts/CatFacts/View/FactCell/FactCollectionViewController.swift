//
//  FactCollectionViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 07/02/21.
//

import Foundation
import UIKit

class FactCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    override func loadView() {
        let factView = FactsView()
        factView.card.delegate = self
        factView.card.dataSource = self
        factView.controller = self
        self.view = factView
        
        

       }

       override func viewDidLoad() {
           super.viewDidLoad()

       }
    
    
    
    
    
    
}

extension FactCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath)
        if let cell = cell as? FactCell {
            // get from API
            cell.cardLabel.text = "Polydactyl cats (a cat with 1-2 extra toes on their paws) have this as a result of a genetic mutation. These cats are also referred to as 'Hemingway cats' because writer Ernest Hemingway reportedly owned dozens of them at his home in Key West, Florida."
        }
        
        return cell
    }
    
    
}
