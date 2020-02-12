//
//  NetwokModule.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Foundation
import Cleanse
import Alamofire

struct NetworkModule: Module {
    
    static func configure(binder: SingletonBinder) {
        binder
            .bind()
            .to { URLSessionConfiguration.ephemeral }
        
        binder.bind(ServerTrustPolicyManager?.self)
            .to(value: nil)
        
        binder.bind(SessionDelegate.self)
            .to(value: SessionDelegate())
        
        binder
            .bind()
            .to(factory: URLSession.init)
        
        binder
            .bind(Alamofire.SessionManager.self)
            .to(factory: SessionManager.init)
    }
    
}
