//
//  MealListAdapter.swift
//  MealApp
//
//  Created by Dmitry Kononov on 24.02.25.
//

import UIKit
import Combine

final class MealListAdapter: NSObject, MealListAdapterProtocol {
    
    private enum Const { static let offsetRowNumber = 5 }
    private var bag: Set<AnyCancellable> = []
    
    var items: CurrentValueSubject<[MealListSection], Never> = .init([])
    
    @Passthrough
    var didSelectItem: AnyPublisher<Meal, Never>
    
    @Passthrough
    var didScrollToEnd: AnyPublisher<Void, Never>
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MealListItemCell.self, forCellReuseIdentifier: "\(MealListItemCell.self)")
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        items
            .sink(receiveValue: { [tableView] _ in tableView.reloadData() })
            .store(in: &bag)
        
    }
    
    
}


extension MealListAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = items.value[section]
        return section.meals.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MealListItemCell.self)", for: indexPath) as? MealListItemCell
        cell?.config(with: items.value[indexPath.section].meals[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        items.value[section].titleLetter.uppercased()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _didSelectItem.combine.send(items.value[indexPath.section].meals[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == items.value.count - 1, indexPath.row > items.value[indexPath.section].meals.count - Const.offsetRowNumber {
            _didScrollToEnd.combine.send()
        }
        
    }
    
}
