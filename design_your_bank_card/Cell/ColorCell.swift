//
//  ColorCell.swift
//  design_your_bank_card
//
//  Created by Алибек Аблайулы on 01.01.2024.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    let checkIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return imageView
    }()
    
    func setColor(colors: [String]) {
        self.layer.cornerRadius = 12
        let gradient = ViewManager.shared.getGradient(colors: colors, frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        self.layer.insertSublayer(gradient, at: 0)
        
        self.clipsToBounds = true
        
        addSubview(checkIconView)
        
        NSLayoutConstraint.activate([
            checkIconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkIconView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func selectItem(){
        checkIconView.isHidden = false
    }
    
    func unselectItem(){
        checkIconView.isHidden = true
    }
    
}
