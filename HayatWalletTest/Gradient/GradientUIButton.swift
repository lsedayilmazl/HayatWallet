//
//  GradientUIButton.swift
//  HayatWalletTest
//
//  Created by Finartz on 1.08.2024.
//

// GradientUIButton.swift
import UIKit

class GradientUIButton {
    func applyGradientToButton(button: UIButton){
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        let color1 = UIColor(red: 94 / 255, green: 199 / 255, blue: 113 / 255, alpha: 1.0)
        let color2 = UIColor(red: 61 / 255, green: 148 / 255 , blue: 91/255, alpha: 1.0)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        // Mask Layer (Köşeleri yuvarlatmak için)
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius)
        maskLayer.path = path.cgPath
        
        // Mevcut gradient layer'ları temizle ve yeni bir tane ekle
        if let existingGradientLayer = button.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingGradientLayer.removeFromSuperlayer()
        }
        
        gradientLayer.mask = maskLayer
        button.layer.insertSublayer(gradientLayer, at: 0)
    }
}

