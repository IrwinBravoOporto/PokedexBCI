//
//  SceneDelegate.swift
//  PokedexBCI
//
//  Created by Irwin Bravo Oporto on 1/04/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.frame = UIScreen.main.bounds
        
        let splashViewController = PokeDexRouter.createModule()
        let navigationController = UINavigationController(rootViewController: splashViewController) // ✅ Envolver en UINavigationController
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }
}
