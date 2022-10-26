//
//  MainCoordinator.swift
//  Presentation
//
//  Created by inforex on 2022/10/17.
//

import Foundation
import UIKit

import Util

public protocol MainCoordinatorDependencies {
    func makeListCoordinator(navigationController: UINavigationController)-> ListCoordinator
    func makeBookmakrCoordinator(navigationController: UINavigationController)-> BookmarkCoordinator
}

public final class MainCoordinator: Coordinator {

    public var childCoordinator: [Coordinator] = []
    public var tabbarController : MainTabbarController
    private let dependencies: MainCoordinatorDependencies

    public init(tabbarController: MainTabbarController,
                dependencies: MainCoordinatorDependencies) {
        self.tabbarController = tabbarController
        self.dependencies = dependencies
    }

    /**
     네비게이션컨트롤러를 생성한다
     - Parameters: -
     - Returns: UINavigationController
     */
    func getNavigation() -> UINavigationController{
        let navigation = UINavigationController()
            navigation.setToolbarHidden(true, animated: false)
            navigation.setNavigationBarHidden(true, animated: false)
        return navigation
    }

    public func start() {
        serviceInit()
    }

    private func serviceInit() {
        let listVC = getNavigation()
        let bookmarkVC = getNavigation()
        let listCoordinator = dependencies.makeListCoordinator(navigationController: listVC)
        let bookmarkCoordinator = dependencies.makeBookmakrCoordinator(navigationController: bookmarkVC)

        childCoordinator = [listCoordinator, bookmarkCoordinator]

        listVC.tabBarItem = UITabBarItem(title: TabMenu.list.title, image: UIImage(systemName: "list.bullet.clipboard"), selectedImage: UIImage(systemName: "list.bullet.clipboard.fill"))
        bookmarkVC.tabBarItem = UITabBarItem(title: TabMenu.bookmark.title, image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))

        tabbarController.viewControllers = [listVC, bookmarkVC]
        tabbarController.modalPresentationStyle = .fullScreen
        tabbarController.selectedIndex = 0

        listCoordinator.start()
        bookmarkCoordinator.start()
    }
}
