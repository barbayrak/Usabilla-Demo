//
//  InsightCollectionViewCell.swift
//  UsabillaAssignment
//
//  Created by Kaan Baris BAYRAK on 20.04.2019.
//  Copyright © 2019 Kaan Baris Bayrak. All rights reserved.
//

import UIKit

class InsightCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var insightViewModel : InsightViewModel! {
        didSet {
            bView.backgroundColor = UIColor(hexString: insightViewModel.colorHex)
            iconImage.image = UIImage(named: insightViewModel.iconName)
            titleLabel.text = insightViewModel.titleString
            descriptionLabel.text = insightViewModel.descriptionString
        }
    }
    
    func setupViews(){
        bView.layer.cornerRadius = 6
        bView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImage.image = UIImage()
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
    }
    
}
