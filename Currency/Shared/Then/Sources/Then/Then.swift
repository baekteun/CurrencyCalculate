import Foundation

public protocol Then {}

public extension Then where Self: AnyObject {
    @discardableResult
    @inlinable
    func set<T>(
        _ keyPath: ReferenceWritableKeyPath<Self, T>, _ value: T
    ) -> Self {
        self[keyPath: keyPath] = value
        return self
    }

    @inlinable
    func then(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}

public extension Then where Self: Any {
    @inlinable
    func then(_ block: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try block(&copy)
        return copy
    }
}

extension NSObject: Then {}
