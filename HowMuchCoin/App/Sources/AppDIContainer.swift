//
//  AppDIContainer.swift
//  App
//
//  Created by inforex on 2022/10/17.
//

import Foundation

final class AppDIContainer {
    func makeMainDIContainer()-> MainDIContainer {
        return MainDIContainer()
    }
}
