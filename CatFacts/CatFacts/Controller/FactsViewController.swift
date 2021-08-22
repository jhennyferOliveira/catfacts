//
//  FactCollectionViewController.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 07/02/21.
//

import Foundation
import UIKit
import CoreData


class FactsViewController: UIViewController {
    
    var itemBehaviour: UIDynamicItemBehavior!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var ball: UIImageView?
    var activityIndicator: UIActivityIndicatorView?
    let impact = UIImpactFeedbackGenerator()
    
    private let viewModelFact = ViewModelFact()
    private let viewModelFavorite = ViewModelFavorite.sharedViewModelFavorite
    var button: UIButton?
    var favorite: Favorite?
    var collectionView: UICollectionView?
    var factCell: FactCell?
    var viewForAnimation: UIView?
    
    override func loadView() {
        let factView = FactView()
        factView.factCard.delegate = self
        factView.factCard.dataSource = self
        factView.controller = self
        factView.delegate = self
        self.collectionView = factView.factCard
        self.button = factView.buttonNewFact
        self.ball = factView.ball
        self.viewForAnimation = factView.animationView
        self.activityIndicator = factView.activityIndicator
        self.view = factView
        button?.addTarget(self, action: #selector(newFactButton), for: .touchUpInside)
        overrideUserInterfaceStyle = .light
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.collectionView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        activityIndicator?.startAnimating()
    }
    
    func setUpAnimation() {
        guard let viewForAnimation = viewForAnimation else {return}
        guard let ball = ball else {return}
        
        animator = UIDynamicAnimator(referenceView: viewForAnimation )
        gravity = UIGravityBehavior(items: [ball])
        gravity.magnitude = 1
        animator.addBehavior(gravity)
        
        itemBehaviour = UIDynamicItemBehavior(items: [ball])
        itemBehaviour.elasticity = 0.8
        itemBehaviour.angularResistance = 0
        animator.addBehavior(itemBehaviour)
        
        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
    }
    
    
    @objc func newFactButton(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        UIView.animate( withDuration: 0.5,
                        delay: 0,
                        usingSpringWithDamping: CGFloat(0.10),
                        initialSpringVelocity: CGFloat(1.0),
                        options: UIView.AnimationOptions.allowUserInteraction,
                        animations: {
                            sender.transform = CGAffineTransform.identity },
                        completion: { Void in() })
        getData()
    }
    
    func getData() {
        activityIndicator?.startAnimating()
        let fact1 = Fact(fact: "", length: 2)
        self.viewModelFact.lastFechedFact = fact1
        
        self.collectionView?.reloadData()
        viewModelFact.fetchFact { fact in
            DispatchQueue.main.async {
                self.viewModelFact.lastFechedFact = fact
                self.activityIndicator?.stopAnimating()
                self.collectionView?.reloadData()
            }
        }
    }
}

extension FactsViewController: HandlePanGestureDelegate {
    
    func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard let viewForAnimation = viewForAnimation else {return}
        guard let ball = ball else {return}
        let location = sender.location(in: viewForAnimation)
        
        // checks if the location where user is panning inside the view's frame
        if viewForAnimation.frame.contains(location) {
            
            if sender.state == UIGestureRecognizer.State.began {
                // while user is touching the collision and gravity effects are removed and the attachment behavior is add so the ball can move with user's motion
                animator.removeBehavior(collision)
                animator.removeBehavior(gravity)
                attachmentBehavior = UIAttachmentBehavior(item: ball, attachedToAnchor: location)
                animator.addBehavior(attachmentBehavior)
            }
            
            else if sender.state == UIGestureRecognizer.State.changed {
                // set the anchor point of attachment behavior
                attachmentBehavior.anchorPoint = location
                
                
            }
            else if sender.state == UIGestureRecognizer.State.ended {
                // remove the attachement behavior so the ball can have the movement of collision and gravity
                animator.removeBehavior(attachmentBehavior)
                itemBehaviour.addLinearVelocity(sender.velocity(in: viewForAnimation), for: ball)
                animator.addBehavior(itemBehaviour)
                animator.addBehavior(gravity)
                animator.addBehavior(collision)
            }
            
        }
        else {
            // if user drags the ball out of the view will be collision and the attachement behavior will be removed so the user can't move the ball outside the view
            animator.addBehavior(collision)
            animator.removeBehavior(attachmentBehavior)
        }
        
    }
}

extension FactsViewController: FavoriteButtonActionDelegateToFactController {
    
    func updateFavoriteButtonState(button: UIButton) {
        viewModelFavorite.isFavorite = !viewModelFavorite.isFavorite
        if viewModelFavorite.isFavorite {
            button.setImage(UIImage(named: "heartFill"), for: .normal)
            guard let fact = viewModelFact.lastFechedFact else {return}
            viewModelFact.save(fact: fact )
        } else {
            button.setImage(UIImage(named: "heartEmpty"), for: .normal)
            guard let fact = viewModelFact.lastFechedFact else {return}
            
            let favoriteFacts = viewModelFavorite.getAll()
            
            for favorite in favoriteFacts{
                if favorite.favoriteText == fact.fact {
                    guard let id = favorite.id else {return}
                    viewModelFavorite.deleteItem(id: id)
                }
            }
        }
    }
}



extension FactsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let factCell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCell.identifier, for: indexPath) as? FactCell else {
            fatalError();
        }
        
        factCell.fact.text = viewModelFact.lastFechedFact?.fact
        
        if viewModelFavorite.isFavorite {
            factCell.favorite.setImage(UIImage(named: "heartFill"), for: .normal)
        } else {
            factCell.favorite.setImage(UIImage(named: "heartEmpty"), for: .normal)
        }

        factCell.delegateFactController = self
        
        
        return factCell
    }
    
    
}
