//
//  StoryViewController.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import Cleanse

class StoryViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let viewModel: StoryViewModel
    
    var webView: WKWebView!
    
    init(viewModel: StoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupViewModel()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

fileprivate extension StoryViewController {
    
    func setupWebView() {
        webView = WKWebView()
        self.view = webView
    }
    
    func setupViewModel() {
        self.viewModel.output.title.drive(self.rx.title).disposed(by: self.disposeBag)
        self.viewModel.output.url
            .unwrap()
            .map { URLRequest(url: $0) }
            .drive(onNext: { [weak self] request in
                self?.webView.load(request)
            }).disposed(by: self.disposeBag)
    }
    
}

// MARK: DI
extension StoryViewController {
    
    struct AssistedFactory: Cleanse.AssistedFactory {
        typealias Seed = HNStory
        typealias Element = StoryViewController
    }
    
    struct Module: Cleanse.Module {
        
        static func configure(binder: SingletonBinder) {
            binder.bindFactory(StoryViewController.self)
                .with(AssistedFactory.self)
                .to(factory: {
                    StoryViewController(viewModel: StoryViewModel.init(story: $0.get()))
                })
        }
        
    }
}
