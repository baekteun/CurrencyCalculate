import CurrencyDomainInterface
import Foundation
import NetworkingInterface

public struct CurrencyDomainComponent {
    public let remoteCurrencyDataSource: any RemoteCurrencyDataSource
    public let currencyRepository: any CurrencyRepository
    public let fetchCurrencyUseCase: any FetchCurrencyUseCase
    public let calculateCurrencyUseCase: any CalculateCurrencyUseCase
    public let validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase

    public init(
        networking: any Networking
    ) {
        self.remoteCurrencyDataSource = RemoteCurrencyDataSourceImpl(networking: networking)
        self.currencyRepository = CurrencyRepositoryImpl(remoteCurrencyDataSource: remoteCurrencyDataSource)
        self.fetchCurrencyUseCase = FetchCurrencyUseCaseImpl(currencyRepository: currencyRepository)
        self.calculateCurrencyUseCase = CalculateCurrencyUseCaseImpl()
        self.validateAmountReceivedUseCase = ValidateAmountReceivedUseCaseImpl()
    }
}
