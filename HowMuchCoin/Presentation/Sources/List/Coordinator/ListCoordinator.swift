//
//  ListCoordinator.swift
//  Presentation
//
//  Created by inforex on 2022/10/18.
//

import Foundation
import UIKit
import Util

// 의존성 주입을 위한 Coordinator Dependency
public protocol ListCoordinatorDependencies {
    func makeListViewController() -> ListViewController
}

public class ListCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    public var navigationController: UINavigationController
    private let dependencies: ListCoordinatorDependencies
    
    public init(navigationController: UINavigationController,
                dependencies: ListCoordinatorDependencies){
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        let listVC = dependencies.makeListViewController()
        listVC.coordinator = self
        
        self.navigationController.pushViewController(listVC, animated: false)
    }

    deinit {
        print(#file)
    }
}
