//
//  AppDelegate.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 1/04/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splashViewController = PokeDexRouter.createModule()
        let navigationController = UINavigationController(rootViewController: splashViewController) // ✅ Envolver en UINavigationController
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()

        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        return true
    }
}

