//
//  MainDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/17.
//

import Foundation
import UIKit

import Presentation

final class MainDIContainer {

    public init() {}

    /// MainCoordinator 생성
    func makeMainCoordinator(tabbarController: MainTabbarController)-> MainCoordinator {
        return MainCoordinator(tabbarController: tabbarController, dependencies: self)
    }

    /// List DI Container 생성
    public func makeListDIContainer()-> ListDIContainer {
        return ListDIContainer()
    }

    /// Bookmark DI Container 생성
    public func makeBookmarkDIContainer()-> BookmarkDIContainer {
        return BookmarkDIContainer()
    }
}

extension MainDIContainer: MainCoordinatorDependencies {
    func makeListCoordinator(navigationController: UINavigationController) -> ListCoordinator {
        let diContainer = makeListDIContainer()

        return diContainer.makeListCoordinator(navigationController: navigationController)
    }

    func makeBookmakrCoordinator(navigationController: UINavigationController) -> BookmarkCoordinator {
        let diContainer = makeBookmarkDIContainer()

        return diContainer.makeBookmarkCoordinator(navigationController: navigationController)
    }
}
