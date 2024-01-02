//
//  ViewManager.swift
//  design_your_bank_card
//
//  Created by Алибек Аблайулы on 31.12.2023.
//

import UIKit

class ViewManager {
    
    var colors: [[String]] = [
        ["#16A085", "#003F32"],
        ["#9A00D1", "#45005D"],
        ["#FA6000", "#FAC6A6"],
        ["#DE0007", "#8A0004"],
        ["#2980B9", "#2771A1"],
        ["#E74C3C", "#93261B"],
    ]
    
    var images: [UIImage] = [.icon1, .icon2, .icon3, .icon4, .icon5, .icon6]
    
    static let shared = ViewManager()
    
    private init(){}
    
    func getGradient(colors: [String], frame: CGRect = CGRect(x: 0, y: 0, width: 306, height: 175)) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map({ color in
            return UIColor(hexString: color).cgColor
        })
        
        gradient.frame = frame
        
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradient.locations = [0, 1]
        
        return gradient
    }
    
    func getCard(colors: [String], balance: CGFloat, number: Int, icon: UIImage) -> UIView {
        let cardView: UIView = {
            let cardView = UIView()
            let gradient = getGradient(colors: colors)
            
            cardView.clipsToBounds = true
            cardView.layer.cornerRadius = 30
            cardView.layer.addSublayer(gradient)
            
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.widthAnchor.constraint(equalToConstant: 306).isActive = true
            cardView.heightAnchor.constraint(equalToConstant: 175).isActive = true
            
            return cardView
        }()
        
        let bankCardIcon: UIImageView = {
            let bankIcon = UIImageView()
            bankIcon.image = icon
            bankIcon.contentMode = .scaleAspectFit
            bankIcon.layer.opacity = 0.3
            
            bankIcon.tag = 3
            
            bankIcon.translatesAutoresizingMaskIntoConstraints = false
            bankIcon.widthAnchor.constraint(equalToConstant: 164).isActive = true
            bankIcon.heightAnchor.constraint(equalToConstant: 164).isActive = true
            
            return bankIcon
        }()
        
        let cardBalance: UILabel = {
            let label = UILabel()
            label.text = "$\(balance)"
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            label.textColor = .white
            
            return label
        }()
        
        let cardNumber: UILabel = {
            let label = UILabel()
            label.text = "**** \(number)"
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.layer.opacity = 0.3
            
            return label
        }()
        
        let numberStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            
            stack.addArrangedSubview(cardBalance)
            stack.addArrangedSubview(cardNumber)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            return stack
        }()
        
        cardView.addSubview(bankCardIcon)
        cardView.addSubview(numberStack)
        
        NSLayoutConstraint.activate([
            bankCardIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: -10),
            bankCardIcon.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
            
            numberStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 35),
            numberStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -35),
            numberStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -35)
        ])
        
        return cardView
    }
    
    func collectionTitleCreator(titleText: String) -> UILabel {
        let label = UILabel()
        label.text = titleText
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func collectionViewCreator(id: String, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 65, height: 65)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.restorationIdentifier = id
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }
}
