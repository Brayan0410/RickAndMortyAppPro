//
//  SceneDelegate.swift
//  RickAndMortyAppPro
//
//  Created by Brayan Gutierrez Juarez on03/04/26.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let networkMonitor = NetworkMonitor()
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = scene as? UIWindowScene else { return }

        let container = AppContainer()

        let rootView = SplashView() 
            .environmentObject(container.favoritesManager)
            .environmentObject(networkMonitor)

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: rootView)

        self.window = window
        window.makeKeyAndVisible()
    }
}
