//
//  MainVM.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import Foundation
import Combine

protocol MainRouterProtocol {
    func openDetailsMeal(meal: Meal)
    
}

protocol MainNetworkServiceProtocol {
    func getRandomMeal() -> AnyPublisher<Meal?, Error>
}

final class MainVM: MainViewModelProtocol {
    private var bag: Set<AnyCancellable> = []
    
    var randomDidTap: PassthroughSubject<Void, Never> = .init()
    var listDidTap: PassthroughSubject<Void, Never> = .init()
    
    private let networkService: MainNetworkServiceProtocol
    
    private let router: MainRouterProtocol
    
    init(networkService: MainNetworkServiceProtocol, router: MainRouterProtocol) {
        self.networkService = networkService
        self.router = router
        bind()
    }
    
    private func bind() {
        randomDidTap
            .flatMap { [networkService] in networkService.getRandomMeal() }
            .replaceError(with: nil)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [router] in router.openDetailsMeal(meal: $0) })
            .store(in: &bag)
    }
}


