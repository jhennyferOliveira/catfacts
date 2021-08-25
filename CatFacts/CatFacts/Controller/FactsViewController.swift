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
    
    var ball: UIImageView?
    var ballBehavior: UIDynamicItemBehavior!
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var viewForAnimation: UIView?
    
    private let viewModelFact = ViewModelFact()
    private let viewModelFavorite = ViewModelFavorite.sharedInstance
    var collectionView: UICollectionView?
    var activityIndicator: UIActivityIndicatorView?
    
    override func loadView() {
        let factView = FactView()
        factView.factCard.delegate = self
        factView.factCard.dataSource = self
        factView.controller = self
        factView.delegatePanGesture = self
        factView.delegateNewFactButton = self
        self.collectionView = factView.factCard
        self.ball = factView.ball
        self.viewForAnimation = factView.animationView
        self.activityIndicator = factView.activityIndicator
        self.view = factView
        overrideUserInterfaceStyle = .light
        getNewFact()
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

        ballBehavior = UIDynamicItemBehavior(items: [ball])
        ballBehavior.elasticity = 0.8
        ballBehavior.angularResistance = 0
        animator.addBehavior(ballBehavior)

        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

    }
    
    func getNewFact() {
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
                ballBehavior.addLinearVelocity(sender.velocity(in: viewForAnimation), for: ball)
                animator.addBehavior(ballBehavior)
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
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
        viewModelFavorite.currentFactIsFavorite = !viewModelFavorite.currentFactIsFavorite
        if viewModelFavorite.currentFactIsFavorite {
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

extension FactsViewController: NewFactButtonDelegate {
    
    func getNewFact(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        UIView.animate( withDuration: 0.5,
                        delay: 0,
                        usingSpringWithDamping: CGFloat(0.10),
                        initialSpringVelocity: CGFloat(1.0),
                        options: UIView.AnimationOptions.allowUserInteraction,
                        animations: {
                            sender.transform = CGAffineTransform.identity },
                        completion: { Void in() })
        getNewFact()
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

        if viewModelFavorite.currentFactIsFavorite {
            factCell.favorite.setImage(UIImage(named: "heartFill"), for: .normal)
        } else {
            factCell.favorite.setImage(UIImage(named: "heartEmpty"), for: .normal)
        }

        factCell.delegateFactController = self


        return factCell
    }
}
