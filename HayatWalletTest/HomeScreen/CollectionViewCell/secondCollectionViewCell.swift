//
//  secondCollectionViewCell.swift
//  HayatWalletTest
//
//  Created by Finartz on 5.08.2024.
//

import UIKit

class secondCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    static let identifier = "secondCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "secondCollectionViewCell" , bundle: nil)
    }

}
