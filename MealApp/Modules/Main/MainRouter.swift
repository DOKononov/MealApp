//
//  MainRouter.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit

final class MainRouter: MainRouterProtocol {
    weak var root: UIViewController?
    private let container: Container

    init(container: Container) {
        self.container = container
    }
    
    func openDetailsMeal(meal: Meal) {
        let vc = DetailsAssembler.make(meal: meal, container: container)
        root?.navigationController?.pushViewController(vc, animated: true)
    }
    
}


