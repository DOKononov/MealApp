//
//  MealListRouter.swift
//
//  Created by Dmitry Kononov on 24.02.25
//

import UIKit

final class MealListRouter: MealListRouterProtocol {
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


