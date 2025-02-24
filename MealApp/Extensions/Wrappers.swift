//
//  Wrappers.swift
//  MealApp
//
//  Created by Dmitry Kononov on 24.02.25.
//

import Combine

@propertyWrapper
class CurrentValue<Event, Failure, SubjectType: CurrentValueSubject<Event, Failure>> {
    let combine: CurrentValueSubject<Event, Failure>
    
    var wrappedValue: AnyPublisher<Event, Failure> {
        return combine.eraseToAnyPublisher()
    }
    
    init(value: Event) {
        self.combine = CurrentValueSubject(value)
    }
}

@propertyWrapper
class Passthrough<Event, Failure, SubjectType: PassthroughSubject<Event, Failure>> {
    let combine: PassthroughSubject<Event, Failure>
    
    var wrappedValue: AnyPublisher<Event, Failure> {
        return combine.eraseToAnyPublisher()
    }
    
    init() {
        self.combine = .init()
    }
}
