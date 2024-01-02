//
//  ViewBuilder.swift
//  design_your_bank_card
//
//  Created by Алибек Аблайулы on 31.12.2023.
//

import UIKit

class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    
    var controller: UIViewController
    var view: UIView
    
    var bankCard = UIView()
    
    var collorsCollectionView: UICollectionView!
    var iconsCollectionView: UICollectionView!
    
    var bankCardColor: [String] = ["#16A085", "#003F32"] {
        willSet {
            if let bankCardView = view.viewWithTag(2) {
                bankCardView.layer.sublayers?.remove(at: 0)
                
                let gradient = manager.getGradient(colors: newValue)
                bankCardView.layer.insertSublayer(gradient, at: 0)
            }
        }
    }
    
    var bankCardIcon: UIImage = .icon2 {
        willSet {
            if let bankCardImageView = view.viewWithTag(3) as? UIImageView {
                bankCardImageView.image = newValue
            }
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupTitle(title: String){
        titleLabel.text = title
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func setupCard(){
        bankCard = manager.getCard(colors: bankCardColor, balance: 99.67, number: 1234, icon: bankCardIcon)
        bankCard.tag = 2
        
        view.addSubview(bankCard)
        
        NSLayoutConstraint.activate([
            bankCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bankCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
        ])
    }
    
    func setupColorsCollectionView(){
        let colorsTitleView: UILabel = {
            let titleView = manager.collectionTitleCreator(titleText: "Select color")
            return titleView
        }()
        
        self.collorsCollectionView = manager.collectionViewCreator(id: "colors", dataSource: self, delegate: self)
        collorsCollectionView.register(ColorCell.self, forCellWithReuseIdentifier: "colorsCollection")
        
        view.addSubview(colorsTitleView)
        view.addSubview(collorsCollectionView)
        
        NSLayoutConstraint.activate([
            colorsTitleView.topAnchor.constraint(equalTo: bankCard.bottomAnchor, constant: 40),
            colorsTitleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            colorsTitleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            collorsCollectionView.topAnchor.constraint(equalTo: colorsTitleView.bottomAnchor, constant: 20),
            collorsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collorsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupIconsCollectionView(){
        let iconsTitleView: UILabel = {
            let titleView = manager.collectionTitleCreator(titleText: "Add shapes")
            
            return titleView
        }()
        
        iconsCollectionView = manager.collectionViewCreator(id: "icons", dataSource: self, delegate: self)
        iconsCollectionView.register(IconCell.self, forCellWithReuseIdentifier: "iconsCollection")
        
        view.addSubview(iconsTitleView)
        view.addSubview(iconsCollectionView)
        
        NSLayoutConstraint.activate([
            iconsTitleView.topAnchor.constraint(equalTo: collorsCollectionView.bottomAnchor, constant: 50),
            iconsTitleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            iconsTitleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            iconsCollectionView.topAnchor.constraint(equalTo: iconsTitleView.bottomAnchor, constant: 20),
            iconsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            iconsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupDescription(){
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.layer.opacity = 0.5
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: iconsCollectionView.bottomAnchor, constant: 42),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
    
    func setupContinueBuitton() {
        let continueButton: UIButton = {
            let continueButton = UIButton(type: .system)
            continueButton.layer.cornerRadius = 20
            continueButton.backgroundColor = .white
            continueButton.setTitle("Continue", for: .normal)
            continueButton.setTitleColor(.black, for: .normal)
            continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            
            continueButton.layer.shadowColor = UIColor.white.cgColor
            continueButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            continueButton.layer.shadowOpacity = 0.5
            continueButton.layer.shadowRadius = 10
            
            continueButton.translatesAutoresizingMaskIntoConstraints = false
            continueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
            return continueButton
        }()
        
        view.addSubview(continueButton)
        NSLayoutConstraint.activate([
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -57)
        ])
    }
}

extension ViewBuilder: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case "colors":
            return manager.colors.count
        case "icons":
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case "colors":
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorsCollection", for: indexPath) as? ColorCell {
                cell.setColor(colors: manager.colors[indexPath.item])
                return cell
            }
        case "icons":
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconsCollection", for: indexPath) as? IconCell {
                let icon = manager.images[indexPath.item]
                cell.configurationCell(icon: icon)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case "colors":
            let colorIndex = indexPath.item
            let selectedColor = manager.colors[colorIndex]
            self.bankCardColor = selectedColor
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
            break
        case "icons":
            let selectedIconIndex = indexPath.item
            let selectedIcon = manager.images[selectedIconIndex]
            self.bankCardIcon = selectedIcon
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
            break
        default: return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case "colors":
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.unselectItem()
        case "icons":
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.unselectItem()
        default: return
        }
    }

}

