//
//  Coordinator.swift
//  Util
//
//  Created by inforex on 2022/10/17.
//

import Foundation

public protocol Coordinator {
    var childCoordinator : [Coordinator] { get set }
    func start()
}
