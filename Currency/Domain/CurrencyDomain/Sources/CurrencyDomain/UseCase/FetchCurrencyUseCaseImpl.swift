import CurrencyDomainInterface

final class FetchCurrencyUseCaseImpl: FetchCurrencyUseCase {
    private let currencyRepository: any CurrencyRepository

    init(currencyRepository: any CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }

    func callAsFunction(source: String, target: String) async throws -> Double {
        try await currencyRepository.fetchCurrency(source: source, target: target)
    }
}
