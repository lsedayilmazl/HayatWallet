//
//  Token.swift
//  HayatWalletTest
//
//  Created by Finartz on 31.07.2024.
//

import Foundation

class Transaction {
    static let shared = Transaction()
    private init(){
        
    }
    func saveToken(token: String){
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "authToken")
    }
    func getToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "authToken")
    }
    func deleteToken(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "authToken")
    }
    func saveUsername(username: String) {
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "userName")
    }

    func getUsername() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "userName")
    }
    func saveFirstname(firstname: String) {
        let defaults = UserDefaults.standard
        defaults.set(firstname, forKey: "firstName")
    }
    func getFirstname() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "firstName")
    }
}
