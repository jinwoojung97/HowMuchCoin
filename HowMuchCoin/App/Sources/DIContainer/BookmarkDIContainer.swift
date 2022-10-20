//
//  BookmarkDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit

import Presentation



final class BookmarkDIContainer {
    // MARK: Coordinator
    func makeBookmarkCoordinator(navigationController: UINavigationController)-> BookmarkCoordinator {
        return BookmarkCoordinator(navigationController:navigationController, dependencies: self)
    }
}

extension BookmarkDIContainer: BookmarkCoordinatorDependencies {
    func makeBookmarkViewController() -> BookmarkViewController {
        return BookmarkViewController.create()
    }
}
