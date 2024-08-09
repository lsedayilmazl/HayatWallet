//
//  HomeScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 29.07.2024.
//

import Foundation
import UIKit

class PersonalinfoScreen: UIViewController {
    
    @IBOutlet weak var labelPersonelInfo: UILabel!
    @IBOutlet weak var fullNameView: CustomView!
    @IBOutlet weak var emailView: CustomView!
    @IBOutlet weak var phoneNumberView: CustomView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    private let viewModel = PersonalinfoViewModel()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
//        backButton.layer.cornerRadius = 14
//        let backButtonItem = UIBarButtonItem(customView: backButton)
//        navigationItem.leftBarButtonItem = backButtonItem
        updateUI()
    }
    
//    @IBAction func backButtonTapped(_sender: UIButton){
//        navigationController?.popViewController(animated: true)
//    }
    func updateUI() {
        viewModel.fetchUserInfo { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let item):
                    self?.configureStackView(with: item)
                case .failure(let error):
                    print("Failed to fetch user info: \(error)")
                }
            }
        }
    }
    private func configureStackView(with item: Item){
        let fullName = "\(item.firstName ?? "") \(item.lastName ?? "")"
        fullNameView.configureText(title: "İsim Soyisim", description: fullName)
        phoneNumberView.configureText(title: "Telefon Numarası", description: item.phoneNumber ?? "Bilinmiyor")
        emailView.configureText(title: "Email", description: item.email ?? "Bilinmiyor")
    }
    
    @IBAction func logOutButtonTapped(_sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let defineUserVC = storyboard.instantiateViewController(withIdentifier: "DefineUserScreen") as! DefineUserScreen
        self.navigationController?.pushViewController(defineUserVC, animated: true)
            }
}






