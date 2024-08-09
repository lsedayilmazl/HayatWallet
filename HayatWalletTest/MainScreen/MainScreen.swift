//
//  MainScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 25.07.2024.
//
// MainScreen.swift
import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var lblMainOne: UILabel!
    @IBOutlet weak var lblMainTwo: UILabel!
    @IBOutlet weak var lblMainThree: UILabel!
    @IBOutlet weak var btnBeCustomer: UIButton!
    @IBOutlet weak var btnAlreadyCustomer: UIButton!
    
    private let viewModel = MainScreenViewModel()
    private let gradient = GradientUIButton()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.applyGradientToButton(button: btnBeCustomer)
    }
    
    @IBAction func btnAlreadyCustomerTapped(_ sender: UIButton) {
        viewModel.handleAlreadyCustomerTapped(from: self)
    }
    
    private func configureView() {
        
        lblMainThree.attributedText = viewModel.lblMainThreeAttributedText
        lblMainOne.attributedText = viewModel.lblMainOneAttributedText
        gradient.applyGradientToButton(button: btnAlreadyCustomer)
    }
}




