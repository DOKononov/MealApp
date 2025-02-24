//
//  DetailsVM.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import Combine
import UIKit

protocol DetailsRouterProtocol {}

protocol DetailsNetworkServiceProtocol {
    func getImage(for url: String) -> AnyPublisher<UIImage?, Error>
}

final class DetailsVM: DetailsViewModelProtocol {
    var model: Meal
    private var bag: Set<AnyCancellable> = []
    private let networkService: DetailsNetworkServiceProtocol
    
    @CurrentValue(value: nil)
    var imageDidLoad: AnyPublisher<UIImage?, Never>
    
    private let router: DetailsRouterProtocol
    
    init(model: Meal, router: DetailsRouterProtocol, networkService: DetailsNetworkServiceProtocol) {
        self.model = model
        self.router = router
        self.networkService = networkService
        bind()
    }
    
    private func bind() {
        networkService
            .getImage(for: model.imageUrl)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .subscribe(_imageDidLoad.combine)
            .store(in: &bag)
        
    }
}


