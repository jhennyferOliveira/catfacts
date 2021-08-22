//
//  FactsView.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

protocol HandlePanGestureDelegate {
    func handlePanGesture(sender: UIPanGestureRecognizer)
}

class FactView: UIView {
    var controller: FactsViewController?
    var delegate: HandlePanGestureDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewHierarchy()
        setAnimationViewConstraints()
        setCatConstraints()
        setViewForEyesConstraints()
        setFloorConstraints()
        setFactCardConstraints()
        setBallConstraints()
        setButtonFactConstraints()
        setActivityIndicatorConstraints()
        self.backgroundColor = .yellowPrimary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var animationView: UIView = {
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
    
    lazy var cat: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cat")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var floor: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "floor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ball: UIImageView = {
        let view = UIImageView(frame: CGRect(x: animationView.bounds.maxX, y: animationView.bounds.maxY , width: 64, height: 64))
        view.image = UIImage(named: "ball")
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(delegatePanGestureAction))
        view.addGestureRecognizer(panGestureRecognizer)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var factCard: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(FactCell.self, forCellWithReuseIdentifier: FactCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 20
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
    
    
    func setUpViewHierarchy() {
        self.addSubview(animationView)
        self.addSubview(factCard)
        self.addSubview(buttonNewFact)
        animationView.addSubview(cat)
        animationView.addSubview(floor)
        animationView.addSubview(ball)
        cat.addSubview(viewForEyes)
        factCard.addSubview(activityIndicator)
    }
    
    func setAnimationViewConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: self.topAnchor),
            animationView.leftAnchor.constraint(equalTo: self.leftAnchor),
            animationView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func setCatConstraints() {
        NSLayoutConstraint.activate([
            cat.bottomAnchor.constraint(equalTo: floor.bottomAnchor,constant: -5),
            cat.widthAnchor.constraint(equalToConstant: 89),
            cat.heightAnchor.constraint(equalToConstant: 192),
            cat.centerXAnchor.constraint(equalTo: animationView.centerXAnchor)
        ])
    }
    
    func setViewForEyesConstraints() {
        NSLayoutConstraint.activate([
            viewForEyes.centerXAnchor.constraint(equalTo: cat.centerXAnchor),
            viewForEyes.heightAnchor.constraint(equalToConstant: 11.11),
            viewForEyes.widthAnchor.constraint(equalToConstant: 36.9),
            viewForEyes.topAnchor.constraint(equalTo: cat.topAnchor, constant: 46.6)
        ])
    }
    
    func setFloorConstraints() {
        NSLayoutConstraint.activate([
            floor.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 5),
            floor.widthAnchor.constraint(equalTo: animationView.widthAnchor),
            floor.centerXAnchor.constraint(equalTo: animationView.centerXAnchor)
        ])
    }
    
    func setFactCardConstraints() {
        NSLayoutConstraint.activate([
            factCard.widthAnchor.constraint(equalToConstant: 336),
            factCard.heightAnchor.constraint(equalToConstant: 242),
            factCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            factCard.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 22)
        ])
    }
    
    func setBallConstraints() {
        NSLayoutConstraint.activate([
            ball.bottomAnchor.constraint(equalTo: floor.bottomAnchor, constant: 40),
            ball.widthAnchor.constraint(equalToConstant: 64),
            ball.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setButtonFactConstraints() {
        NSLayoutConstraint.activate([
            buttonNewFact.topAnchor.constraint(equalTo: factCard.bottomAnchor, constant: 16),
            buttonNewFact.heightAnchor.constraint(equalToConstant: 42),
            buttonNewFact.widthAnchor.constraint(equalToConstant: 138),
            buttonNewFact.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonNewFact.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }
    
    func setActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: factCard.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: factCard.centerYAnchor)
        ])
    }
    
    @objc func delegatePanGestureAction(sender: UIPanGestureRecognizer) {
        delegate?.handlePanGesture(sender: sender)
    }
    
}

extension FactView {
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 336, height: 242)
        return flowLayout
    }
}
