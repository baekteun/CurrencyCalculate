import CurrencyDomainInterface

final class CurrencyRepositoryImpl: CurrencyRepository {
    private let remoteCurrencyDataSource: any RemoteCurrencyDataSource

    init(remoteCurrencyDataSource: any RemoteCurrencyDataSource) {
        self.remoteCurrencyDataSource = remoteCurrencyDataSource
    }

    func fetchCurrency(source: String, target: String) async throws -> Double {
        try await remoteCurrencyDataSource.fetchCurrency(source: source, target: target)
    }
}
