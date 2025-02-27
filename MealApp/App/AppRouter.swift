//
//  AppRouter.swift
//  MealApp
//
//  Created by Dmitry Kononov on 27.02.25.
//

import UIKit


final class AppRouter {
    
    private let windowScene: UIWindowScene
    private var window: UIWindow?
    private let container = ContainerConfigurator.make()
    private lazy var launchService: LaunchService = container.resolve()
    
    init(windowScene: UIWindowScene) {
        self.windowScene = windowScene
    }
    
    func start() {
        launchService.didLaunch()
        window = UIWindow(windowScene: windowScene)
        openMain()
    }
    
    private func openMain() {
        let vc = MainAssembler.make(container: container)
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    
    
}
