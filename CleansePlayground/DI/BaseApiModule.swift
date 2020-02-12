//
//  BaseApiModule.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Foundation
import Cleanse

struct BaseApiURL: Tag {
    typealias Element = URL
}

struct BaseApiURLModule: Module {
    
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(URL.self)
            .tagged(with: BaseApiURL.self)
            .to(value: URL(string: "https://hacker-news.firebaseio.com/v0")!)
    }
}
