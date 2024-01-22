import CalculateCurrencyFeatureInterface
import CurrencyDomainInterface
import UIKit

final class CalculateCurrencyFactoryImpl: CalculateCurrencyFactory {
    private let fetchCurrencyUseCase: any FetchCurrencyUseCase
    private let calculateCurrencyUseCase: any CalculateCurrencyUseCase
    private let validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase

    init(
        fetchCurrencyUseCase: any FetchCurrencyUseCase,
        calculateCurrencyUseCase: any CalculateCurrencyUseCase,
        validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase
    ) {
        self.fetchCurrencyUseCase = fetchCurrencyUseCase
        self.calculateCurrencyUseCase = calculateCurrencyUseCase
        self.validateAmountReceivedUseCase = validateAmountReceivedUseCase
    }

    func makeViewController() -> UIViewController {
        let viewModel = CalculateCurrencyViewModel(
            fetchCurrencyUseCase: fetchCurrencyUseCase,
            calculateCurrencyUseCase: calculateCurrencyUseCase,
            validateAmountReceivedUseCase: validateAmountReceivedUseCase
        )
        return CalculateCurrencyViewController(viewModel: viewModel)
    }
}
