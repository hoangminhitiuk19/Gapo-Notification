//
//  AppDelegate.swift
//  Gapo-Notification
//
//  Created by Dung on 8/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let view = MyViewController()
        let navigation = UINavigationController(rootViewController: view)
        window = UIWindow( frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        navigation.navigationBar.prefersLargeTitles = true
        return true
    }

    


}

