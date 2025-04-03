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
        
        // Configuración para testing
        if ProcessInfo.processInfo.environment["UITEST_MODE"] == "1" {
            // Vista mínima para pruebas
            let testVC = UIViewController()
            testVC.view.backgroundColor = .white
            window?.rootViewController = testVC
        } else {
            // Configuración normal
            let splashViewController = PokeDexRouter.createPokeDexModule()
            window?.rootViewController = UINavigationController(rootViewController: splashViewController)
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setupStandardEnvironment() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let splashViewController = PokeDexRouter.createPokeDexModule()
        let navigationController = UINavigationController(rootViewController: splashViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func setupUITestingEnvironment() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Configuración mínima para pruebas
        let testViewController = UIViewController()
        testViewController.view.backgroundColor = .white
        window?.rootViewController = testViewController
        window?.makeKeyAndVisible()
        
        // Espera breve para que la ventana esté lista
        RunLoop.current.run(until: Date().addingTimeInterval(0.1))
    }
}

