//
//  ViewController.swift
//  design_your_bank_card
//
//  Created by Алибек Аблайулы on 31.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#141414")
        
        builder.setupTitle(title: "Design your virtual card")
        builder.setupCard()
        builder.setupColorsCollectionView()
        builder.setupIconsCollectionView()
        builder.setupDescription()
        builder.setupContinueBuitton()
    }

}

