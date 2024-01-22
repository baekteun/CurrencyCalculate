public protocol RemoteCurrencyDataSource {
    func fetchCurrency(source: String, target: String) async throws -> Double
}
