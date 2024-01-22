import Foundation
import UIKit
import Networking
import CurrencyDomain

struct AppDependency {
    let rootViewController: UIViewController
}

extension AppDependency {
    static func resolve() -> AppDependency {
        let networkingComponent = NetwokringComponent()

        let currencyDomainComponent = CurrencyDomainComponent(networking: networkingComponent.networking)

        return AppDependency(
            rootViewController: UIViewController()
        )
    }
}
