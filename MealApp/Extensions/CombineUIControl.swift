//
//  CombineUIControl.swift
//  MealApp
//
//  Created by Dmitry Kononov on 4.02.25.
//

import UIKit
import Combine

final class CombineUIControl {
    private weak var root: UIControl?
    
    private let publisher = PassthroughSubject<Void, Never>()
    
    init(root: UIControl) {
        self.root = root
    }
    
    func onEvent(_ type: UIControl.Event) -> AnyPublisher<Void, Never> {
        root?.addTarget(self, action: #selector(eventDidHandle), for: type)
        return Just(self)
            .combineLatest(publisher)
            .map { $1 }
            .eraseToAnyPublisher()
    }
    
    @objc private func eventDidHandle() {
        publisher.send()
    }
}

extension UIControl {
    var combine: CombineUIControl {
        return CombineUIControl(root: self)
    }
}

extension UIButton {
    func tap() -> AnyPublisher<Void, Never> {
        return combine.onEvent(.touchUpInside)
    }
}

extension UITextField {
    func textDidChanged() -> AnyPublisher<Void, Never> {
        return combine.onEvent(.editingChanged)
    }
}
