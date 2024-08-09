//
//  CollectionViewCell.swift
//  HayatWalletTest
//
//  Created by Finartz on 31.07.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    static let identifier = "CollectionViewCell"
    
    let gradient = GradientUIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gradient.applyGradientToButton(button: button)
        button.layer.cornerRadius = 10
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell" , bundle: nil)
    }
}


