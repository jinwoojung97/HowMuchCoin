//
//  BookmarkCoordinator.swift
//  Presentation
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit

import Util

// 의존성 주입을 위한 Coordinator Dependency
public protocol BookmarkCoordinatorDependencies {
    func makeBookmarkViewController() -> BookmarkViewController
}

public final class BookmarkCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    public var navigationController: UINavigationController
    private let dependencies: BookmarkCoordinatorDependencies

    public init(navigationController: UINavigationController,
                dependencies: BookmarkCoordinatorDependencies){
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    public func start() {
        let bookmarkVC = dependencies.makeBookmarkViewController()
        bookmarkVC.coordinator = self

        self.navigationController.pushViewController(bookmarkVC, animated: false)
    }

    deinit {
        print(#file)
    }
}
