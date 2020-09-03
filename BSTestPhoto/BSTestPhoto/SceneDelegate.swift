//
//  SceneDelegate.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 8/31/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit

// MARK: - SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public properties
    
    var window: UIWindow?
    
    // MARK: - Public methods
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainViewController = MainViewController()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.rootViewController = mainViewController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
}
