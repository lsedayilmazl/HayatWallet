//
//  LoginScreenViewModel.swift
//  HayatWalletTest
//
//  Created by Finartz on 1.08.2024.
//

import Foundation

class LoginScreenViewModel {
    
  
    var loginSuccessHandler: (() -> Void)?
    var loginFailureHandler: ((String) -> Void)?
    
    func login(username: String, password: String) {
        Network.shared.loginControl(userName: username, password: password) { [weak self] result in
                switch result {
                case .success(_):
                    // Handle successful login
                    DispatchQueue.main.async {
                        self?.loginSuccessHandler?()
                    }
                case .failure(_):
                    // Handle failure
                    DispatchQueue.main.async {
                        self?.loginFailureHandler?("Giriş başarısız!")
                    }
                }
            }
        }
    
    
    
}
