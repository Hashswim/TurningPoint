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
        let homeNavigationController = UINavigationController(rootViewController: MainHomeTabControllerCollectionViewController())

        homeNavigationController.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))


        self.viewControllers = [homeNavigationController]
    }
    

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
