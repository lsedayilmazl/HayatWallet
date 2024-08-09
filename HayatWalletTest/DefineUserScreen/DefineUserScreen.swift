//
//  DefineUserScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 7.08.2024.
//

import Foundation
import UIKit

class DefineUserScreen: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgiveMeButton: UIButton!
    
    private let gradient = GradientUIButton()
    let viewModel = LoginScreenViewModel()
    
    override func viewDidLoad(){
        
        
        super.viewDidLoad()
        setupViewModel()
        self.navigationItem.hidesBackButton = true
        gradient.applyGradientToButton(button: loginButton)
        userNameLabel.text = Transaction.shared.getFirstname()
    }
    
    private func setupViewModel() {
        viewModel.loginSuccessHandler = { [weak self] in
            self?.handleLoginSuccess()
        }
        viewModel.loginFailureHandler = { [weak self] message in
            self?.showAlertMsg(message: message)
        }
    }
    private func handleLoginSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.navigationController?.setViewControllers([tabBarController], animated: true)
        
    }
    @IBAction func forgiveMeButtonTapped(_sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainScreenVC = storyboard.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        self.navigationController?.pushViewController(mainScreenVC, animated: true)
        Transaction.shared.deleteToken()
    }
    
    @IBAction func loginButtonTapped(_sender: UIButton) {
        guard let password = passTextField.text, !password.isEmpty else {
            showAlertMsg(message: "Şifre boş bırakılamaz!")
            return
        }
        viewModel.login(username: Transaction.shared.getUsername()!, password: password)
    }
    private func showAlertMsg(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
        }
        
        }
    }

