//
//  secondCustomView.swift
//  HayatWalletTest
//
//  Created by Finartz on 5.08.2024.
//
import UIKit

class secondCustomView: UIView {
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var addMoneyButton: UIButton!
    @IBOutlet weak var sendButtton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var mytableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    static let identifier = "secondCustomView"
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    func initSubviews() {
        let nib = UINib(nibName: "secondCustomView", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.backgroundColor = UIColor.clear
            addSubview(view)
            view.frame = self.bounds
            
        }
    }
}
