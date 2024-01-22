import CalculateCurrencyFeature
import CurrencyDomain
import Foundation
import Networking
import UIKit

struct AppDependency {
    let rootViewController: UIViewController
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let networkingComponent = NetwokringComponent()

        let currencyDomainComponent = CurrencyDomainComponent(networking: networkingComponent.networking)

        let calculateCurrencyFeatureComponent = CalculateCurrencyFeatureComponent(
            fetchCurrencyUseCase: currencyDomainComponent.fetchCurrencyUseCase,
            calculateCurrencyUseCase: currencyDomainComponent.calculateCurrencyUseCase,
            validateAmountReceivedUseCase: currencyDomainComponent.validateAmountReceivedUseCase
        )

        let calculateCurrencyFactory = calculateCurrencyFeatureComponent.calculateCurrencyFactory

        let rootViewController = calculateCurrencyFactory.makeViewController()

        return AppDependency(
            rootViewController: rootViewController
        )
    }
}
