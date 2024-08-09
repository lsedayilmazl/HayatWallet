//
//  Authentication.swift
//  HayatWalletTest
//
//  Created by Finartz on 29.07.2024.
//

import Foundation

struct LoginInfo : Codable {
    let item: Item?
    let errorCode: Int?
    let errorMessage: String?
}
struct Item: Codable{
    let redirectToTwoFactor: Bool?
    let enabledTwoFactorMethods: String?
    let token: String?
    let inSuccess: Bool?
    let message: String?
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let email: String?
    
}
