//
//  MealListVM.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import Foundation
import Combine
import Storage

protocol MealListRouterProtocol {
    func openDetailsMeal(meal: Meal)
}

protocol MealListNetworkServiceProtocol {
    func getMeals(by letter: String) -> AnyPublisher<[Meal], Error>
}

final class MealListVM: MealListViewModelProtocol {
    
    private let router: MealListRouterProtocol
    private let networkService: MealListNetworkServiceProtocol
    private let storage = MealsStorage()
    private var bag: Set<AnyCancellable> = []

    @CurrentValue(value: [])
    var items: AnyPublisher<[MealListSection], Never>
    var didSelectItem: PassthroughSubject<Meal, Never> = .init()
    var loadNextSection: PassthroughSubject<Void, Never> = .init()
    var didAddToFavourite: PassthroughSubject<Meal, Never> = .init()

    
    private var abc: [String] = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "", "u", "v", "w", "x", "y", "z"]
    
    init(router: MealListRouterProtocol, networkService: MealListNetworkServiceProtocol) {
        self.router = router
        self.networkService = networkService
        bind()
        loadNextSection.send()
    }
    
    private func bind() {
        didSelectItem
            .sink(receiveValue: {[router] in router.openDetailsMeal(meal: $0) })
            .store(in: &bag)
        
        loadNextSection
            .compactMap { [weak self] _ in self?.abc.first }
            .removeDuplicates()
            .flatMap { [networkService] in networkService.getMeals(by: $0) }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .compactMap { [weak self] in
                guard
                    let letter = self?.abc.removeFirst(),
                    !$0.isEmpty
                else { return nil }
                return MealListSection(titleLetter: letter, meals: $0)
            }
            .map { [_items] in _items.combine.value + [$0] }
            .subscribe(_items.combine)
            .store(in: &bag)
        
        didAddToFavourite
            .map { MealToDTOMapper.map(from: $0) }
            .sink(receiveValue: { [storage] in
                storage.create(dto: $0) { _ in }
                print("\($0.name) did add to favourite")
                
            })
            .store(in: &bag)
    }
}


