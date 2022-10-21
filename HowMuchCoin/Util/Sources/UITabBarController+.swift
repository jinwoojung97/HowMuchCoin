//
//  UITabBarController+.swift
//  Util
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit

public extension UITabBarController{
    public func setTabBarDesign(){
        self.tabBar.layer.addBorder([.top], color: .systemGray, width: 0.3)
        self.tabBar.backgroundColor = .dynamicGray
        self.tabBar.unselectedItemTintColor = .dynamicLabel
        self.tabBar.tintColor = .dynamicLabel
    }
}
