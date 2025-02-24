//
//  MainAssembler.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit

final class MainAssembler {
    private init() {}
    
    static func make(container: Container) -> UIViewController {
        let router = MainRouter(container: container)
        let networkService: NetworkService = container.resolve()
        let vm = MainVM(networkService: networkService, router: router)
        let vc = MainVC(viewModel: vm)
        router.root = vc
        return vc
    }
}



