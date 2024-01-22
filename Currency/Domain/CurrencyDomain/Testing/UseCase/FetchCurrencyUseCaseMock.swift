import CurrencyDomainInterface

public final class FetchCurrencyUseCaseMock: FetchCurrencyUseCase {
    public init() {}

    public private(set) var callCount = 0
    public var handler: (String, String) async throws -> Double = { _, _ in 0 }
    public func callAsFunction(source: String, target: String) async throws -> Double {
        callCount += 1
        return try await handler(source, target)
    }
}
