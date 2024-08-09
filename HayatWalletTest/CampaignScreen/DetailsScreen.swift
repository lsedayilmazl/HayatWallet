//
//  DetailsScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 1.08.2024.
//

import Foundation
import UIKit
import Kingfisher

class DetailsScreen: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    var body: HayatCampaignModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: (body?.imageUrl)!)
        imageView.kf.setImage(with: url)
        labelTitle.text = (body?.title)!
    }
    
}
