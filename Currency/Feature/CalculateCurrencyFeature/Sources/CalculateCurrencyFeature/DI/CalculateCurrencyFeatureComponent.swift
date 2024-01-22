import CalculateCurrencyFeatureInterface
import CurrencyDomainInterface

public struct CalculateCurrencyFeatureComponent {
    public let calculateCurrencyFactory: any CalculateCurrencyFactory

    public init(
        fetchCurrencyUseCase: any FetchCurrencyUseCase,
        calculateCurrencyUseCase: any CalculateCurrencyUseCase,
        validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase
    ) {
        self.calculateCurrencyFactory = CalculateCurrencyFactoryImpl(
            fetchCurrencyUseCase: fetchCurrencyUseCase,
            calculateCurrencyUseCase: calculateCurrencyUseCase,
            validateAmountReceivedUseCase: validateAmountReceivedUseCase
        )
    }
}
