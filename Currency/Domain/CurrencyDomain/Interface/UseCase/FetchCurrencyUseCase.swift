public protocol FetchCurrencyUseCase {
    func callAsFunction(source: String, target: String) async throws -> Double
}
