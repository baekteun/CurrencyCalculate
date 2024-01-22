import CurrencyDomainInterface

public final class ValidateAmountReceivedUseCaseMock: ValidateAmountReceivedUseCase {
    public init() {}

    public private(set) var callCount = 0
    public var handler: (Double) -> Bool = { _ in false }
    public func callAsFunction(amount: Double) -> Bool {
        callCount += 1
        return handler(amount)
    }
}
