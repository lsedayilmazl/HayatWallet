//
//  TranscTableViewCell.swift
//  HayatWalletTest
//
//  Created by Finartz on 4.08.2024.
//

import UIKit

class TranscTableViewCell: UITableViewCell {
    
    static let identifier = "TranscTableViewCell"
    
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TranscTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
