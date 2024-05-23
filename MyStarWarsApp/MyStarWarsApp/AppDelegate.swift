//
//  AppDelegate.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 23/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window:UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .orange
    window?.rootViewController = ViewController()
    
    return true
  }

}

