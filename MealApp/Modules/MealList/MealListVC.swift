//
//  MealListVC.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit
import SnapKit
import Combine

protocol MealListViewModelProtocol {
    //out
    var items: AnyPublisher<[MealListSection], Never> { get }
    //in
    var didSelectItem: PassthroughSubject<Meal, Never> { get }
    var loadNextSection: PassthroughSubject<Void, Never> { get }
    var didAddToFavourite: PassthroughSubject<Meal, Never> { get }
}

protocol MealListAdapterProtocol {
    var tableView: UITableView { get }
    //in
    var items: CurrentValueSubject<[MealListSection], Never> { get }
    //out
    var didSelectItem: AnyPublisher<Meal, Never> { get }
    var didScrollToEnd: AnyPublisher<Void, Never> { get }
    var didAddToFavourite: AnyPublisher<Meal, Never> { get }
}

final class MealListVC: UIViewController {
    
    private let viewModel: MealListViewModelProtocol
    private let adapter: MealListAdapterProtocol
    
    private var bag: Set<AnyCancellable> = []
    
    private var tableView: UITableView {
        return adapter.tableView
    }
    
    init(viewModel: MealListViewModelProtocol, adapter: MealListAdapterProtocol) {
        self.viewModel = viewModel
        self.adapter = adapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
        viewModel.items
            .subscribe(adapter.items)
            .store(in: &bag)
        
        adapter.didSelectItem
            .subscribe(viewModel.didSelectItem)
            .store(in: &bag)
        
        adapter.didScrollToEnd
            .subscribe(viewModel.loadNextSection)
            .store(in: &bag)
        
        adapter.didAddToFavourite
            .subscribe(viewModel.didAddToFavourite)
            .store(in: &bag)
    }
    
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}




