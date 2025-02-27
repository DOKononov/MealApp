//
//  LaunchService.swift
//  MealApp
//
//  Created by Dmitry Kononov on 27.02.25.
//

import Combine
import UIKit

final class LaunchService {
    
    private var bag: Set<AnyCancellable> = []
    
    init() {
        bind()
    }
    
    private func bind() {
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink(receiveValue: { notification in print("did enter foreground") })
            .store(in: &bag)
    }
    
    func didLaunch() {
        
    }
}
