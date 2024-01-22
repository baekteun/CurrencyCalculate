import CurrencyDomainInterface

public final class CurrencyRepositoryMock: CurrencyRepository {
    public init() {}

    public private(set) var fetchCurrencyCallCount = 0
    public var fetchCurrencyHandler: (String, String) async throws -> Double = { _, _ in 0 }
    public func fetchCurrency(source: String, target: String) async throws -> Double {
        fetchCurrencyCallCount += 1
        return try await fetchCurrencyHandler(source, target)
    }
}
