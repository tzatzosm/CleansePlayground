//
//  TopStoriesViewModel.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct TopStoriesViewModel {
    
    struct Input {
        var load: PublishRelay<()>
    }
    
    struct Output {
        let stories: Driver<[HNStory]>
    }
    
    let input: Input
    let output: Output
    
    init(topStoriesService: TopStoriesService) {
        let load = PublishRelay<()>()
        
        let stories = load.startWith(()).flatMap { topStoriesService.getTopStoriesObservable() }.asDriver(onErrorJustReturn: [HNStory]())
        
        input = Input(load: load)
        output = Output(stories: stories)
        
    }
    
}
