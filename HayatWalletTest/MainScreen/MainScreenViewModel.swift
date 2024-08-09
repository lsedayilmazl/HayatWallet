//
//  MainViewModel.swift
//  HayatWalletTest
//
//  Created by Finartz on 31.07.2024.
//

// MainScreenViewModel.swift
import UIKit

class MainScreenViewModel {
    
    private let model = MainModel(welcomeMessage: "", infoText: "")
    
    var lblMainTwoText: String {
        return model.welcomeMessage
    }
    
    var lblMainThreeText: String {
        return model.infoText
    }
    
    var lblMainOneAttributedText: NSAttributedString {
        let heavyFont = UIFont.systemFont(ofSize: 24, weight: .heavy)
        let lightFont = UIFont.systemFont(ofSize: 23, weight: .thin)
       

        let firstPart = "Hayat Cüzdan'"
        let secondPart = "a"
       
        let attributedString = NSMutableAttributedString()

        // Apply heavy font to first part
        let firstPartAttributes: [NSAttributedString.Key: Any] = [.font: heavyFont]
        let firstPartAttributedString = NSAttributedString(string: firstPart, attributes: firstPartAttributes)
        attributedString.append(firstPartAttributedString)

        // Apply thin font to second part
        let secondPartAttributes: [NSAttributedString.Key: Any] = [.font: lightFont]
        let secondPartAttributedString = NSAttributedString(string: secondPart, attributes: secondPartAttributes)
        attributedString.append(secondPartAttributedString)
        
       
        
        return attributedString
    }
    
    var lblMainThreeAttributedText: NSAttributedString {
        
        let boldPart = "X Dakikada"
        let normalPart = " birbirimizi tanıyıp Hayat Finans\ndünyasının müşterisi olabilirsiniz"
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let normalFont = UIFont.systemFont(ofSize: 17)

        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 24
        
        let attributedString2 = NSMutableAttributedString(string: lblMainThreeText)
        attributedString2.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString2.length))
        print(attributedString2.string)
        
        let boldPartAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]
        let boldPartAttributedString = NSAttributedString(string: boldPart, attributes: boldPartAttributes)
        attributedString2.append(boldPartAttributedString)
        
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: normalFont]
        let normalAttributedString = NSAttributedString(string: normalPart, attributes: normalAttributes)
        attributedString2.append(normalAttributedString)
        return attributedString2
    }
    
    func handleAlreadyCustomerTapped(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginScreenVC = storyboard.instantiateViewController(withIdentifier: "LoginScreen")
        viewController.navigationController?.pushViewController(loginScreenVC, animated: true)
    }
}

