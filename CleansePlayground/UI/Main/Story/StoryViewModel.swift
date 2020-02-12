//
//  StoryViewModel.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Cleanse
import RxSwift
import RxCocoa

struct StoryViewModel {
    
    struct Output {
        let title: Driver<String>
        let url: Driver<URL?>
    }
    
    let output: Output
    
    init(story: HNStory) {
        let titleDriver = Driver.just(story.title)
        let urlDriver = Driver.just(URL(string: story.url ?? ""))
        self.output = Output(title: titleDriver, url: urlDriver)
    }
    
}
