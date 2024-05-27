//
//  AppDelegate.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  let databaseManger = MyDatabaseManager.shared
  let reachabilityManager = ReachabilityManagerImpl.shared
  let networkManager = NetworkManager.shared
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
    
    let peopleLocalRepository = PeopleLocalRepository(
        databaseManger: databaseManger
    )
    let peopleFetcher =  PeopleRemoteRepository(
        networkManager: networkManager
    )
    let peopleViewModel = PeopleViewModel(
        peopleLocalRepository: peopleLocalRepository,
        reachabilityManager: reachabilityManager,
        peopleFetcher: peopleFetcher
    )
    
    let speciesLocalRepository = SpeciesLocalRepository(
        databaseManger: databaseManger
    )
    let speciesFetcher =  SpeciesRemoteRepository(
        networkManager: networkManager
    )
    let speciesViewModel = SpeciesViewModel(
        speciesLocalRepository: speciesLocalRepository,
        reachabilityManager: reachabilityManager,
        speicesFetcher: speciesFetcher
    )
    
    
    let peopleViewController = PeopleViewController(viewModel: peopleViewModel)
    
    let speciesViewController =  SpeciesViewController(viewModel: speciesViewModel)
    
    let peopleVC = UINavigationController(rootViewController: peopleViewController)
    peopleVC.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person.3"), tag: 0)
    
    let speciesVC = UINavigationController(rootViewController: speciesViewController)
    speciesVC.tabBarItem = UITabBarItem(title: "Species", image: UIImage(systemName: "leaf.arrow.circlepath"), tag: 1)
    
    tabBarController.viewControllers = [peopleVC, speciesVC]
    
    return tabBarController
  }
}


