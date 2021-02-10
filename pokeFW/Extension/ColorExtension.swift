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
}

public extension UIColor {
    
    struct ColorPalette {
        
        static let backgroundColor = UIColor.white
        
        static let secondaryBackgroundColor =  UIColor.colorFromRGB(red: 250, green: 251, blue: 253)
        
        static let labelColor = UIColor.colorFromRGB(red: 76, green: 85, blue: 108)
        
        static let secondaryLabelColor = UIColor.colorFromRGB(red: 76, green: 85, blue: 108).withAlphaComponent(0.7)
    }
}


