//
//  ContainerConfigurator.swift
//  MealApp
//
//  Created by Dmitry Kononov on 24.02.25.
//

import Foundation

final class ContainerConfigurator {
    private init() {}
    
    static func make() -> Container {
        let container = Container()
        
        container.lazyRegister { NetworkService() }
//        container.lazyRegister { LaunchService() }
        
        return container
    }
}
