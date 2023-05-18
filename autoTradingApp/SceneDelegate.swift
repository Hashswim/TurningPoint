//
//  SceneDelegate.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit
import XingAPIMobile

class SceneDelegate: UIResponder, UIWindowSceneDelegate, XingAPIDelegate{

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            let viewController = XingLoginViewController() // XingLoginViewController의 인스턴스 생성
            let navigationController = UINavigationController(rootViewController: viewController) // UINavigationController로 감싸기

            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController // UINavigationController를 초기 뷰 컨트롤러로 설정
            self.window = window
            window.makeKeyAndVisible()

            // API 시작
            let eBESTAPI: XingAPI = XingAPI.getInstance()
            eBESTAPI.initAPI()
            eBESTAPI.setNetworkDelegate(viewController)
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

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        //API 종료
        let eBESTAPI: XingAPI = XingAPI.getInstance()
        eBESTAPI.close()
    }
    
    
    //연결종료
    func onDisconnect() {
        print("onDisconnect");
    }
    
    //연결시도
    func onRetryConnnect(_ count: Int) {
        print("onRetryConnnect : \(count)");
    }
    
    func onReceiveData(_ data: ReceiveData!) {
    }
    
    func onReceiveMessage(_ msg: ReceiveMessage!) {
    }
    
    func onReceiveError(_ msg: ReceiveMessage!) {
    }
    
    func onReleaseData(_ rqID: Int, code: String!) {
    }
    
    func onTimeOut(_ rqID: Int, code: String!) {
    }
    
    func onReceiveRealData(_ bcCode: String!, key: String!, data: Data!) {
    }

}

