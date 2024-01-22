public protocol CurrencyRepository {
    func fetchCurrency(source: String, target: String) async throws -> Double
}
