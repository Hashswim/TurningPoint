//
//  SceneDelegate.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let networkManager = NetworkManager()

        let user: [User] = UserCoreDataManager.shared.readUserEntity()
        if user.count == 0 {
            let mainViewController = InitialViewController()

            let navigationController = UINavigationController(rootViewController: mainViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            UserInfo.shared.name = user[0].name
            UserInfo.shared.favoriteList = user[0].favoriteItems
            UserInfo.shared.trainingList = user[0].trainingItems
            UserInfo.shared.appKey = user[0].appKey

            networkManager.getAccessToken(appKey: user[0].appKey!, secretKey: user[0].secretKey!, completion: { token in
                UserInfo.shared.accessToken = token
                let mainViewController = MainTabBarController()
                self.window?.rootViewController = mainViewController
                self.window?.makeKeyAndVisible()
            })
        }
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }

        // change the root view controller to your specific view controller
        window.rootViewController = vc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

