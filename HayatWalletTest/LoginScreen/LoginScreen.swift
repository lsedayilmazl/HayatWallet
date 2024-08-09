//
//  LoginScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 26.07.2024.
//

// LoginScreen.swift
import UIKit

class LoginScreen: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var noOrTcTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var unblockSimButton: UIButton!
    @IBOutlet weak var orButton: UIButton!
    @IBOutlet weak var beCustomerButton: UIButton!
    
    
    private let gradient = GradientUIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var loadingOverlay: UIView?
    private let viewModel = LoginScreenViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.hidesBackButton = true
        configureUI()
        setupViewModel()
    }
    
    private func configureUI() {
        gradient.applyGradientToButton(button: logInButton)
        setupTextFields()
        setupActivityIndicator()
    }
    
    private func setupViewModel() {
        viewModel.loginSuccessHandler = { [weak self] in
            self?.handleLoginSuccess()
        }
        viewModel.loginFailureHandler = { [weak self] message in
            self?.showAlertMsg(message: message)
            self?.hideLoadingIndicator()
        }
    }
    private func setupTextFields() {
        let placeholderText = "Müşteri No / TCKN"
        let placeholderText2 = "Şifre"
        let placeholderColor = UIColor.black
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor
        ]
        noOrTcTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: placeholderText2, attributes: attributes)
        
        noOrTcTextField.layer.cornerRadius = 16
        noOrTcTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 16
        passwordTextField.layer.masksToBounds = true
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        showLoadingIndicator()
        guard let username = noOrTcTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlertMsg(message: "Gerekli bilgiler boş bırakılamaz!")
            hideLoadingIndicator()
            return
        }
        viewModel.login(username: username, password: password)
    }
    
    private func showLoadingIndicator() {
        loadingOverlay = UIView(frame: view.bounds)
        loadingOverlay?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.addSubview(loadingOverlay!)
        activityIndicator.startAnimating()
    }
    private func handleLoginSuccess() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.navigationController?.setViewControllers([tabBarController], animated: true)
        
        hideLoadingIndicator()
    }
    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        loadingOverlay?.removeFromSuperview()
        loadingOverlay = nil
    }
    
    private func showAlertMsg(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Uyarı", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
        }
    }
}
