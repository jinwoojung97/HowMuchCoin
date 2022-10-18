//
//  ListDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import Presentation
import UIKit

final class ListDIContainer {
    // MARK: Coordinator
    func makeListCoordinator(navigationController: UINavigationController)-> ListCoordinator {
        return ListCoordinator(navigationController:navigationController, dependencies: self)
    }
}

extension ListDIContainer: ListCoordinatorDependencies {
    func makeListViewController() -> ListViewController {
        return ListViewController.create()
    }
}
