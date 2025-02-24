//
//  DetailsAssembler.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit

final class DetailsAssembler {
    private init() {}
    
    static func make(meal: Meal, container: Container) -> UIViewController {
        let router = DetailsRouter()
        let networkService: NetworkService = container.resolve()
        let vm = DetailsVM(model: meal, router: router, networkService: networkService)
        let vc = DetailsVC(viewModel: vm)
        router.root = vc
        return vc
    }
}



