//
//  UIColor+.swift
//  Util
//
//  Created by inforex on 2022/10/21.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        let rgb = rgb / 255.0
        self.init(red: rgb, green: rgb, blue: rgb, alpha:a)
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        let red = r / 255,
            green = g / 255,
            blue = b / 255
        self.init(red: red, green: green, blue: blue, alpha:a)
    }

    class var dynamicBackground: UIColor { return UtilAsset.background.color }
    class var dynamicGray: UIColor { return UtilAsset.gray.color }
    class var dynamicLabel: UIColor { return UtilAsset.label.color }
}
