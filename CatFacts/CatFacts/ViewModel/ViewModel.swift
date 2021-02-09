//
//  ViewModel.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class ViewModel {
    let service = APIHandler()
    
//    var fact: Fact? {
//        didSet {
//            self.collectionView = controller.collectionView
//            self.collectionView?.reloadData()
//        }
//    }
    var fact: Fact?
    func getFact(completionHandler: @escaping (Fact) -> Void) {
        service.getDataFromAPI(completionHandler: completionHandler)
    }
    
}
