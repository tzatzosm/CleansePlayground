//
//  SceneDelegate.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import UIKit
import Cleanse

import AlamofireNetworkActivityLogger

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var componentFactory: ComponentFactory<MainComponent>?
    var componentFactoryInjector: PropertyInjector<SceneDelegate>?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("Unable to cast UIScene to UIWindowScene")
        }
        setupNetworkActivityLogs()
        setupApplication(windowScene: windowScene)
        
        // Make sure everything went according to plan
        precondition(window != nil)
        
        window!.makeKeyAndVisible()
    }
    
}

fileprivate extension SceneDelegate {
    
    func setupNetworkActivityLogs() {
        NetworkActivityLogger.shared.level = .info
        NetworkActivityLogger.shared.startLogging()
    }
    
    func setupApplication(windowScene: UIWindowScene) {
        componentFactory = try? ComponentFactory.of(MainComponent.self)
        componentFactoryInjector = componentFactory?.build(windowScene)
        componentFactoryInjector?.injectProperties(into: self)
    }
    
}

extension SceneDelegate {
    
    func injectProperties(_ window: UIWindow) {
        self.window = window
    }
    
}

