//
//  FactsView.swift
//  CatFacts
//
//  Created by Jhennyfer Rodrigues de Oliveira on 05/02/21.
//

import Foundation
import UIKit

class FactsView: UIView {
    var controller: FactCollectionViewController?
    
    lazy var viewForAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 283))
        view.backgroundColor = .yellowPrimary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewForLeftEyeAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 193.5, y: 125.7, width: 16.95, height: 11.69))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewForRightEyeAnimation: UIView = {
        let view = UIView(frame: CGRect(x: 169.5, y: 125.7, width: 16.95, height: 11.69))
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var ball: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ball")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    lazy var eyes: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eyes")
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
        button.addTarget(self, action: #selector(newFactButton), for: .touchUpInside)
        button.setTitle("New fact", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpConstraints() {
        self.addSubview(viewForAnimation)
        viewForAnimation.addSubview(animationImage)
        self.addSubview(card)
        self.addSubview(buttonNewFact)
        viewForAnimation.addSubview(ball)
        viewForAnimation.addSubview(viewForLeftEyeAnimation)
        viewForAnimation.addSubview(viewForRightEyeAnimation)
        viewForLeftEyeAnimation.addSubview(leftPupil)
        viewForRightEyeAnimation.addSubview(rightPupil)
        
        
        NSLayoutConstraint.activate([
            viewForAnimation.topAnchor.constraint(equalTo: self.topAnchor),
            viewForAnimation.leftAnchor.constraint(equalTo: self.leftAnchor),
            viewForAnimation.heightAnchor.constraint(equalToConstant: 283),
            viewForAnimation.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            animationImage.bottomAnchor.constraint(equalTo: viewForAnimation.bottomAnchor),
            animationImage.heightAnchor.constraint(equalToConstant: 206),
            animationImage.widthAnchor.constraint(equalToConstant: 375),
            
            card.widthAnchor.constraint(equalToConstant: 336),
            card.heightAnchor.constraint(equalToConstant: 242),
            card.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            card.topAnchor.constraint(equalTo: viewForAnimation.bottomAnchor, constant: 22),
            
            
            buttonNewFact.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            buttonNewFact.heightAnchor.constraint(equalToConstant: 37),
            buttonNewFact.widthAnchor.constraint(equalToConstant: 138),
            buttonNewFact.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            viewForLeftEyeAnimation.topAnchor.constraint(equalTo: viewForAnimation.topAnchor, constant: 125.7),
            viewForLeftEyeAnimation.leftAnchor.constraint(equalTo: viewForAnimation.leftAnchor, constant: 193.5),
            viewForLeftEyeAnimation.widthAnchor.constraint(equalToConstant: 16.95),
            viewForLeftEyeAnimation.heightAnchor.constraint(equalToConstant: 11.69),
            
            leftPupil.centerXAnchor.constraint(equalTo: viewForLeftEyeAnimation.centerXAnchor),
            leftPupil.widthAnchor.constraint(equalToConstant: 8),
            leftPupil.heightAnchor.constraint(equalToConstant: 8),
            
            viewForRightEyeAnimation.topAnchor.constraint(equalTo: viewForAnimation.topAnchor, constant: 125.7),
            viewForRightEyeAnimation.leftAnchor.constraint(equalTo: viewForAnimation.leftAnchor, constant: 169.5),
            viewForRightEyeAnimation.widthAnchor.constraint(equalToConstant: 16.95),
            viewForRightEyeAnimation.heightAnchor.constraint(equalToConstant: 11.69),
            
            rightPupil.centerXAnchor.constraint(equalTo: viewForRightEyeAnimation.centerXAnchor),
            rightPupil.widthAnchor.constraint(equalToConstant: 8),
            rightPupil.heightAnchor.constraint(equalToConstant: 8)

        ])
        
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
    
    @objc func newFactButton() {
        print("a")
//  get new fact to show in the screen
    }
}
