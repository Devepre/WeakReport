//
//  WeakReporter.swift
//  WeakReport
//
//  Created by Limitation on 2/23/19.
//  Copyright © 2019 Serhii K. All rights reserved.
//

import Foundation

protocol WeakReporterRegistering: class {
    // swiftlint:disable:next type_name
    associatedtype T: AnyObject
    func registerObserver(_ observer: T)
    func unregisterObserver(_ observer: T)
}

protocol WeakReporterObserving: WeakReporterRegistering {
    var observers: [WeakReference<T>] { get }
    func notifyObservers(_ notify: (T) -> Void)
}

extension WeakReporterObserving {
    func notifyObservers(_ notify: (T) -> Void) {
        observers.compactMap { $0.object }.forEach(notify)
    }
}

class WeakReporter<T: AnyObject>: NSObject, WeakReporterObserving {
    var observers = [WeakReference<T>]()
    public func registerObserver(_ observer: T) {
        observers.append(WeakReference(observer))
    }
    
    public func unregisterObserver(_ observer: T) {
        if let index = observers.index(where: { $0 == WeakReference(observer) }) {
            observers.remove(at: index)
        }
    }
}

public struct WeakReference<T: AnyObject> {
    fileprivate let pointer: UnsafeRawPointer
    public init(_ object: T) {
        pointer = UnsafeRawPointer(Unmanaged.passUnretained(object).toOpaque())
    }
    
    public weak var object: T? {
        // https://swift.org/migration-guide-swift3/se-0107-migrate.html
        return unsafeBitCast(pointer, to: T.self)
    }
}

extension WeakReference: Hashable {
    public var hashValue: Int { return pointer.hashValue }
}

public func ==<T> (lhs: WeakReference<T>, rhs: WeakReference<T>) -> Bool {
    return lhs.pointer == rhs.pointer
}
