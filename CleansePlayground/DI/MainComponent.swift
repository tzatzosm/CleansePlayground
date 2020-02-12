//
//  MainComponent.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Cleanse

struct MainComponent: Cleanse.RootComponent {
    
    typealias Root = PropertyInjector<SceneDelegate>
    typealias Scope = Singleton
    typealias Seed = UIWindowScene

    static func configure(binder: SingletonBinder) {
        binder.include(module: UIKitModule.self)
        binder.include(module: CoreAppModule.self)
        binder.include(module: HttpClient.Module.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root> {
        return bind.propertyInjector(configuredWith: MainComponent.configureAppDelegateInjector)
    }
    
    static func configureAppDelegateInjector(binder bind: PropertyInjectionReceiptBinder<SceneDelegate>) -> BindingReceipt<PropertyInjector<SceneDelegate>> {
        return bind.to(injector: SceneDelegate.injectProperties)
    }
}

struct CoreAppModule: Cleanse.Module {
    
    static func configure(binder: SingletonBinder) {
        binder.include(module: MainTabBarViewController.Module.self)
        binder.include(module: StoryViewController.Module.self)
        binder.include(module: TopStoriesViewController.Module.self)
    }
    
}


