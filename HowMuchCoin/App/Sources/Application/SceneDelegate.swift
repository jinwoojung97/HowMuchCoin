//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by inforex on 2022/10/12.
//

import UIKit
import Domain
import Repository
import Presentation
import Util
import Service
import ThirdPartyLib

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDIContainer = AppDIContainer()
    var appCoordinator: AppCordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        let vc = MainTabbarController()
        window.rootViewController = vc
        
        appCoordinator = AppCordinator(tabbarController: vc, appDIContainer: appDIContainer)
        appCoordinator?.start()
        
        self.window = window
        window.makeKeyAndVisible()
        
        RepositoryTest()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
