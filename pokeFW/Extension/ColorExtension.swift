//
//  ColorExtension.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation
import UIKit

public extension UIColor {
    
    // MARK: - Color functions
    
    static func colorFromRGB(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    
    static func getColor(darkColor: UIColor, lightColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            switch  UITraitCollection.current.userInterfaceStyle {
            case .dark:
                return darkColor
            case .light:
                return lightColor
            default:
                return lightColor
            }
        }
        else {
            return lightColor
        }
    }
}

public extension UIColor {
    
    struct ColorPalette {
        
        static let backgroundColor = UIColor.getColor(darkColor: UIColor.colorFromRGB(red: 19, green: 18, blue: 28), lightColor: UIColor.colorFromRGB(red: 250, green: 251, blue: 253))
        
        static let secondaryBackgroundColor = UIColor.getColor(darkColor: UIColor.colorFromRGB(red: 32, green: 34, blue: 45), lightColor: UIColor.white)
        
        static let labelColor = UIColor.getColor(darkColor: UIColor.white, lightColor: UIColor.colorFromRGB(red: 76, green: 85, blue: 108))
        
        static let secondaryLabelColor = UIColor.getColor(darkColor: UIColor.white.withAlphaComponent(0.7), lightColor: UIColor.colorFromRGB(red: 76, green: 85, blue: 108).withAlphaComponent(0.7))
    }
}
