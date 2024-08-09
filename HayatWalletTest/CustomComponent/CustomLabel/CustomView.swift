//
//  CustomView.swift
//  HayatWalletTest
//
//  Created by Finartz on 30.07.2024.
//

import UIKit


class CustomView: UIView {
    
    static let identifier = "CustomView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    func initSubviews() {
        let nib = UINib(nibName: CustomView.identifier, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as?
                UIView else {fatalError("Unable to convert nib")}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func configureText(title : String, description : String){
        titleLabel.textColor = UIColor.gray
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
}
