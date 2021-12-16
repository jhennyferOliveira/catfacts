//
//  FactsView.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

protocol HandlePanGestureDelegate {
    func handlePan(sender: UIPanGestureRecognizer)
}

class FactsView: UIView {
    var controller: FactCollectionViewController?
    var delegate: HandlePanGestureDelegate?
    lazy var viewForAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 283))
        view.backgroundColor = .yellowPrimary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .yellowPrimary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var viewForLeftEyeAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 193.5, y: 125.7, width: 15.23, height: 11.11))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftPupil)
        leftPupil.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        leftPupil.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    lazy var viewForRightEyeAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 169.5, y: 125.7, width: 15.23, height: 11.11))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightPupil)
        rightPupil.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rightPupil.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    lazy var leftPupil: UIImageView = {
        let pupil = UIImageView()
        pupil.image = UIImage(named: "pupila")
        pupil.translatesAutoresizingMaskIntoConstraints = false
        return pupil
    }()
    
    lazy var rightPupil: UIImageView = {
        let pupil = UIImageView()
        pupil.image = UIImage(named: "pupila")
        pupil.translatesAutoresizingMaskIntoConstraints = false
        return pupil
    }()
    
    lazy var animationImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cat")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var floorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "floor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    lazy var ball: UIImageView = {
        let view = UIImageView(frame: CGRect(x: viewForAnimation.bounds.maxX, y: viewForAnimation.bounds.maxY , width: 64, height: 64))
        view.image = UIImage(named: "ball")
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    lazy var card: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(FactCell.self, forCellWithReuseIdentifier: FactCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    lazy var buttonNewFact: UIButton = {
        let button = UIButton()
        button.backgroundColor = .purpleAction
        button.setTitle("New fact", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 42/2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var viewForEyes: UIStackView = {
           let stackView = UIStackView(arrangedSubviews: [viewForRightEyeAnimation, viewForLeftEyeAnimation])
        stackView.spacing = 6.41
           stackView.distribution = .fillEqually
           stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()
    
    func setUpConstraints() {
        self.addSubview(viewForAnimation)
        viewForAnimation.addSubview(animationImage)
        viewForAnimation.addSubview(floorImage)
        self.addSubview(card)
        self.addSubview(buttonNewFact)
        viewForAnimation.addSubview(ball)
        animationImage.addSubview(viewForEyes)
        card.addSubview(activityIndicator)
        
        
        NSLayoutConstraint.activate([
            viewForAnimation.topAnchor.constraint(equalTo: self.topAnchor),
            viewForAnimation.leftAnchor.constraint(equalTo: self.leftAnchor),
            viewForAnimation.rightAnchor.constraint(equalTo: self.rightAnchor),

            animationImage.bottomAnchor.constraint(equalTo: floorImage.bottomAnchor,constant: -5),
            animationImage.widthAnchor.constraint(equalToConstant: 89),
            animationImage.heightAnchor.constraint(equalToConstant: 192),
            animationImage.centerXAnchor.constraint(equalTo: viewForAnimation.centerXAnchor),
            
            viewForEyes.centerXAnchor.constraint(equalTo: animationImage.centerXAnchor),
            viewForEyes.heightAnchor.constraint(equalToConstant: 11.11),
            viewForEyes.widthAnchor.constraint(equalToConstant: 36.9),
            viewForEyes.topAnchor.constraint(equalTo: animationImage.topAnchor, constant: 46.6),
            
            
            floorImage.bottomAnchor.constraint(equalTo: viewForAnimation.bottomAnchor, constant: 5),
            floorImage.widthAnchor.constraint(equalTo: viewForAnimation.widthAnchor),
            floorImage.centerXAnchor.constraint(equalTo: viewForAnimation.centerXAnchor),

            
            card.widthAnchor.constraint(equalToConstant: 336),
            card.heightAnchor.constraint(equalToConstant: 242),
            card.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            card.topAnchor.constraint(equalTo: viewForAnimation.bottomAnchor, constant: 22),
            
            ball.bottomAnchor.constraint(equalTo: floorImage.bottomAnchor, constant: 40),
            ball.widthAnchor.constraint(equalToConstant: 64),
            ball.heightAnchor.constraint(equalToConstant: 64),
            
            
            buttonNewFact.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            buttonNewFact.heightAnchor.constraint(equalToConstant: 42),
            buttonNewFact.widthAnchor.constraint(equalToConstant: 138),
            buttonNewFact.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonNewFact.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            activityIndicator.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: card.centerYAnchor)
            
        ])
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        delegate?.handlePan(sender: sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpConstraints()
        card.layer.cornerRadius = 20
        self.backgroundColor = .yellowPrimary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FactsView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 336, height: 242)
        return flowLayout
    }
}
