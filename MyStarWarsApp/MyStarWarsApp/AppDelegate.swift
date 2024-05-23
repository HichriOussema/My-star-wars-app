//
//  AppDelegate.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = createTabBarController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }

    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let peopleVC = UINavigationController(rootViewController: UIViewController())
        peopleVC.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person.3"), tag: 0)
        
        let speciesVC = UINavigationController(rootViewController: UIViewController())
        speciesVC.tabBarItem = UITabBarItem(title: "Species", image: UIImage(systemName: "leaf.arrow.circlepath"), tag: 1)
        
        tabBarController.viewControllers = [peopleVC, speciesVC]
        
        return tabBarController
    }
}


