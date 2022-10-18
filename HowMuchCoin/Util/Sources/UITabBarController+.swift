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
        let appearance = UITabBarAppearance()
        // set tabbar opacity
        appearance.configureWithOpaqueBackground()

        // remove tabbar border line
        appearance.shadowColor = UIColor.clear

        // set tabbar background color
        appearance.backgroundColor = .white

        tabBar.standardAppearance = appearance

        if #available(iOS 15.0, *) {
                // set tabbar opacity
                tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }

        // set tabbar tintColor
        tabBar.tintColor = .black

        // set tabbar shadow
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
        
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.tintColor = .black
    }
}
