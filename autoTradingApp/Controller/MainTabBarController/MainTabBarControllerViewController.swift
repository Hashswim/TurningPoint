//
//  mainTabBarControllerViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/04.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        tabBar.unselectedItemTintColor = MySpecialColors.gray
        tabBar.tintColor = MySpecialColors.tabBarTint
        setUpVCs()
    }
    
    func setUpVCs() {
        viewControllers = [
            createNavController(for: MainHomeTabController(), title: NSLocalizedString("메인홈", comment: ""), image: UIImage(named: "1메인")!),
            createNavController(for: SearchViewController(), title: NSLocalizedString("검색", comment: ""), image: UIImage(named: "2검색")!),
            createNavController(for: TradingViewController(), title: NSLocalizedString("트레이딩", comment: ""), image: UIImage(named: "3트레이딩")!),
            createNavController(for: MyPageViewController(), title: NSLocalizedString("마이페이지", comment: ""), image: UIImage(named: "4마이페이지")!)
        ]
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
//        navController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
        return navController
    }
}
