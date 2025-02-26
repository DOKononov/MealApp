//
//  MealListAssembler.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit

final class MealListAssembler {
    private init() {}
    
    static func make(container: Container) -> UIViewController {
        let router = MealListRouter(container: container)
        let networkService: NetworkService = container.resolve()
        let vm = MealListVM(router: router, networkService: networkService)
        let adapter = MealListAdapter()
        let vc = MealListVC(viewModel: vm, adapter: adapter)
        router.root = vc
        return vc
    }
}



