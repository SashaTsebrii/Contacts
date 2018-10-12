//
//  Extensions.swift
//  Contacts
//
//  Created by Aleksandr Tsebrii on 10/12/18.
//  Copyright © 2018 Aleksandr Tsebrii. All rights reserved.
//

import UIKit

// MARK: -
extension UIFont {
    // Print in log all fonts.
    func fontList() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
}

// MARK: -
extension UIColor {
    // Color from hex.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    // Custom colors.
    struct DesignColor {
        // Interface colors.
        static let screenBackground = UIColor(netHex: 0xEBEBEB)
        
        // General colors.
        static let blue = UIColor(netHex: 0x007AFF)
    }
    
    // Random color.
    class func getRandomColor(int: Int) -> UIColor{
        var float: CGFloat = 0
        if int > 255 {
            float = CGFloat(int % 255)
        } else {
            float = CGFloat(int)
        }
        return UIColor(red: float / 255.0, green: float / 200.0, blue: float / 155.0, alpha: 1.0)
    }
    
}

// MARK: -
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        // Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
