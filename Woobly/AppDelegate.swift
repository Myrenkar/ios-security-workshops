//
//  AppDelegate.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        
        do {
            let usersProvider = try UsersProvider()
            if let _ = usersProvider.loggedInUser {
                navigationController.viewControllers = [ UsersViewController(usersProvider: usersProvider) ]
            } else {
                navigationController.viewControllers = [ LoginViewController() ]
            }
        } catch {
            navigationController.viewControllers = [ LoginViewController() ]
        }
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.contains("real_password=ai3zn2jza") {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Activated"), object: nil, userInfo: nil)
        }
        return true
    }
}

