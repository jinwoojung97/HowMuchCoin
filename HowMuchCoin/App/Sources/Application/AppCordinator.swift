//
//  AppCordinator.swift
//  App
//
//  Created by inforex on 2022/10/17.
//

import Foundation
import UIKit
import Presentation

class AppCordinator {
    var tabbarController: MainTabbarController
    private let appDIContainer: AppDIContainer

    init(tabbarController: MainTabbarController, appDIContainer: AppDIContainer) {
        self.tabbarController = tabbarController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let mainDIContainer = appDIContainer.makeMainDIContainer()
        let mainCoordinator = mainDIContainer.makeMainCoordinator(tabbarController: tabbarController)
        mainCoordinator.start()
    }
}
