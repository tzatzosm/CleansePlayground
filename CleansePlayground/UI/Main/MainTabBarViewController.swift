//
//  MainTabBarViewController.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import UIKit
import Cleanse
import RxSwift

class MainTabBarViewController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainTabBarViewController init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    struct Module: Cleanse.Module {
        
        static func configure(binder: Binder<Unscoped>) {
            binder
                .bind(MainTabBarViewController.self)
                .to(factory: { (viewControllers: [UIViewController]) -> MainTabBarViewController in
                    let mainTabBarViewController = MainTabBarViewController.init()
                    mainTabBarViewController.viewControllers = viewControllers
                    return mainTabBarViewController
                })
            
            binder
                .bind()
                .tagged(with: UIViewController.Root.self)
                .to { $0 as MainTabBarViewController }
        }
        
    }
    
}
