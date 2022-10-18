//
//  MainTabbarController.swift
//  Presentation
//
//  Created by inforex on 2022/10/17.
//

import Foundation
import UIKit
import Util

public enum TabMenu: Int {
    case list = 0, bookmark = 1
    public var title : String {
        switch self {
        case .list:
            return ""
        case .bookmark:
            return ""
        }
    }
}

public class MainTabbarController: UITabBarController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setTabBarDesign()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selected = TabMenu(rawValue: tabBarController.selectedIndex)

        print("Should select viewController: \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
           return true
       }

    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selected = TabMenu(rawValue: tabBarController.selectedIndex)

        print("did select viewController: \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
    }
}
