//
//  IconCell.swift
//  design_your_bank_card
//
//  Created by Алибек Аблайулы on 01.01.2024.
//

import UIKit

class IconCell: UICollectionViewCell {
    
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
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.opacity = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        return imageView
    }()
    
    func configurationCell(icon: UIImage){
        
        backgroundColor = UIColor(hexString: "#1f1f1f")
        layer.cornerRadius = 12
        clipsToBounds = true
        
        iconView.image = icon
        addSubview(iconView)
        addSubview(checkIconView)
        
        NSLayoutConstraint.activate([
            iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -10),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            
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
