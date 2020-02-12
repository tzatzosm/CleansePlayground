//
//  TopStoriesViewController.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 10/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import UIKit
import RxSwift
import Cleanse
import RxDataSources

class TopStoriesViewController: UIViewController {

    let storyFactory: Factory<StoryViewController.AssistedFactory>
    var disposeBag = DisposeBag()
    let viewModel: TopStoriesViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: TopStoriesViewModel,
         storyFactory: Factory<StoryViewController.AssistedFactory>) {
        self.viewModel = viewModel
        self.storyFactory = storyFactory
        super.init(nibName: nil, bundle: nil)
        self.title = "Top Stories"
        self.tabBarItem = UITabBarItem(title: "Top Stories", image: nil, selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("TopStoriesViewController hasn't been initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
    }
        
}

fileprivate extension TopStoriesViewController {
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "TopStoriesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "TopStoriesTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70
    }
    
    func setupViewModel() {
        viewModel.output.stories
            .drive(tableView.rx.items(cellIdentifier: "TopStoriesTableViewCell")) { index, model, cell in
                guard let topStoryCell = cell as? TopStoriesTableViewCell else { return }
                topStoryCell.story = model
        }.disposed(by: self.disposeBag)
        
        Observable.zip(tableView.rx.modelSelected(HNStory.self), tableView.rx.itemSelected, resultSelector: { ($0, $1) })
            .subscribe(onNext: { [weak self] zipped in
                guard let strongSelf = self else { return }
                strongSelf.tableView.deselectRow(at: zipped.1, animated: true)
                let viewController = strongSelf.storyFactory.build(zipped.0)
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
            })
    }
    
}

extension TopStoriesViewController {
    
    struct Module: Cleanse.Module {
        
        static func configure(binder: SingletonBinder) {
            binder
                .bind(TopStoriesViewModel.self)
                .to(factory: TopStoriesViewModel.init)
            
            binder
                .bind(UIViewController.self)
                .intoCollection()
                .to(factory: { (topStoriesViewModel: TopStoriesViewModel, factory: Factory<StoryViewController.AssistedFactory>) in
                    return UINavigationController(rootViewController: TopStoriesViewController(viewModel: topStoriesViewModel,
                                                                                               storyFactory: factory))
                })
        }
        
    }
    
}
