//
//  SomeCenter.swift
//  WeakReport
//
//  Created by Limitation on 2/23/19.
//  Copyright © 2019 Serhii K. All rights reserved.
//

import Foundation

@objc protocol SomeObserving {
    func didBecomeEnable(with value: String)
    func didBecomeDisable(with value: String)
}

class SomeCenter {
    static let shared = SomeCenter()
    
    private let reporter = WeakReporter<SomeObserving>()
    
    private var value = false {
        didSet {
            switch value {
            case true:
                reporter.notifyObservers { $0.didBecomeEnable(with: "True".uppercased()) }
            case false:
                reporter.notifyObservers { $0.didBecomeDisable(with: "False".uppercased()) }
            }
        }
    }
    
    // MARK: - Dumb functions to change datasource value.
    func changeValueToTrue() {
        value = true
    }
    
    func changeValueToFalse() {
        value = false
    }
    
}

extension SomeCenter: WeakReporterRegistering {
    func registerObserver(_ observer: SomeObserving) {
        reporter.registerObserver(observer)
    }
    
    func unregisterObserver(_ observer: SomeObserving) {
        reporter.unregisterObserver(observer)
    }
    
}
