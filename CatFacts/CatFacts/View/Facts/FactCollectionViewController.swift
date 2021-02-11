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
    
    var itemBehaviour: UIDynamicItemBehavior!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var ball: UIImageView?
    var leftPupil: UIImageView?
    
    
    private let viewModelFact = ViewModelFact()
    private let viewModelFavorite = ViewModelFavorite()
    var button: UIButton?
    var favorite: Favorite?
    var collectionView: UICollectionView?
    var factCell: FactCell?
    var viewForAnimation: UIView?
    
    override func loadView() {
        let factView = FactsView()
        factView.card.delegate = self
        factView.card.dataSource = self
        factView.controller = self
        self.collectionView = factView.card
        self.button = factView.buttonNewFact
        button?.addTarget(self, action: #selector(newFactButton), for: .touchUpInside)
        factView.delegate = self
        self.ball = factView.ball
        self.viewForAnimation = factView.viewForAnimation
        self.leftPupil = factView.leftPupil
        self.view = factView
        overrideUserInterfaceStyle = .light
        
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: viewForAnimation! )
        gravity = UIGravityBehavior(items: [self.ball!])
        gravity.magnitude = 1
        animator.addBehavior(gravity)
        
        itemBehaviour = UIDynamicItemBehavior(items: [self.ball!])
        itemBehaviour.elasticity = 0.8
        animator.addBehavior(itemBehaviour)
        
        collision = UICollisionBehavior(items: [self.ball!])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
    }
    
    @objc func newFactButton() {
        getData()
    }
    
    func getData() {
        viewModelFact.getFact { fact in
            DispatchQueue.main.async {
                self.viewModelFact.fact = fact
                self.collectionView?.reloadData()
            }
        }
    }
}

extension FactCollectionViewController: HandlePanGestureDelegate {
    
    func handlePan(sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: viewForAnimation);
        let touchLocation = sender.location(in: self.ball);
        
        if sender.state == UIGestureRecognizer.State.began {
         
            self.animator!.removeAllBehaviors()
            
            let offset = UIOffset(horizontal: touchLocation.x - self.ball!.bounds.midX, vertical: touchLocation.y - self.ball!.bounds.midY)
 
            self.attachmentBehavior = UIAttachmentBehavior(item: self.ball!, offsetFromCenter: offset, attachedToAnchor: location)
            self.animator!.addBehavior(self.attachmentBehavior);
        }
        
        else if sender.state == UIGestureRecognizer.State.changed {
            self.attachmentBehavior!.anchorPoint = location;
            
        }
        else if sender.state == UIGestureRecognizer.State.ended {
         
            self.animator!.removeBehavior(self.attachmentBehavior)
            itemBehaviour = UIDynamicItemBehavior(items: [self.ball!])
            itemBehaviour.addLinearVelocity(sender.velocity(in: self.viewForAnimation), for: self.ball!)
            itemBehaviour.angularResistance = 0
            itemBehaviour.elasticity = 0.8
            animator.addBehavior(itemBehaviour)
            self.animator.addBehavior(self.gravity)
            self.animator.addBehavior(self.collision)
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
