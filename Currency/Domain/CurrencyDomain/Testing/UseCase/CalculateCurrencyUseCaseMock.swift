import CurrencyDomainInterface

public final class CalculateCurrencyUseCaseMock: CalculateCurrencyUseCase {
    public init() {}

    public private(set) var callCount = 0
    public var handler: (Double, Double) -> Double = { _, _ in 0 }
    public func callAsFunction(lhs: Double, rhs: Double) -> Double {
        callCount += 1
        return handler(lhs, rhs)
    }
}
