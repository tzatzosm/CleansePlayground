//
//  HNApiClient.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxSwiftExt
import RxAlamofire
import Cleanse

struct HttpClient {
    let baseURL: URL
    let sessionManager: SessionManager
    
    init(baseURL: TaggedProvider<BaseApiURL>, sessionManager: SessionManager) {
        self.baseURL = baseURL.get()
        self.sessionManager = sessionManager
    }
    
    struct Module: Cleanse.Module {
        
        static func configure(binder: SingletonBinder) {
            binder.include(module: NetworkModule.self)
            binder.include(module: BaseApiURLModule.self)
            
            binder.bind(TopStoriesService.self).to(factory: HttpClient.init)
        }
        
    }
    
}

extension HttpClient {
    
    func request<T: Decodable>(urlRequest: URLRequest) -> Observable<T> {
        return self.sessionManager.rx
            .request(urlRequest: urlRequest)
            .responseData()
            .map { try JSONDecoder().decode(T.self, from: $0.1) }
    }
    
}


protocol TopStoriesService {
    
    func getTopStoriesObservable() -> Observable<[HNStory]>
    
}

extension HttpClient: TopStoriesService {
    
    func getTopStoriesObservable() -> Observable<[HNStory]> {
        let topStories: Observable<[Int]> = self.request(urlRequest: URLRequest(url: baseURL.appendingPathComponent("/topstories.json")))
        return topStories.flatMap { Observable.from($0[0..<10]) }
            .flatMap { self.getStory(storyId: $0) }
            .unwrap()
            .toArray()
            .asObservable()
            
    }
    
    fileprivate func getStory(storyId: Int) -> Observable<HNStory?> {
        return self.request(urlRequest: URLRequest(url: baseURL.appendingPathComponent("/item/\(storyId).json")))
            .catchErrorJustReturn(nil)
    }
    
}



