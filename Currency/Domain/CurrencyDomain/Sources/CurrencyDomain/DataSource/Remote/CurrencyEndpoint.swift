import Foundation
import NetworkingInterface

enum CurrencyEndpoint {
    case fetchCurrency(source: String, target: String)
}

extension CurrencyEndpoint: Endpoint {
    var baseURL: String {
        guard let bundlePath = Bundle.module.path(forResource: "Currencylayer", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: bundlePath) as? [String: AnyObject],
              let baseURLString = dict["BASE_URL"] as? String
        else {
            fatalError("Currencylayer plist or BASE_URL plsit value is not exist")
        }
        return baseURLString
    }
    
    var route: Route {
        switch self {
        case .fetchCurrency:
            return .get("/live")
        }
    }

    var query: [String: String]? {
        switch self {
        case let .fetchCurrency(source, target):
            guard let bundlePath = Bundle.module.path(forResource: "Currencylayer", ofType: "plist"),
                  let dict = NSDictionary(contentsOfFile: bundlePath) as? [String: AnyObject],
                  let apiKeyString = dict["API_KEY"] as? String
            else {
                fatalError("Currencylayer plist or API_KEY plsit value is not exist")
            }
            return [
                "access_key": apiKeyString,
                "source": source,
                "currencies": target,
                "format": "1"
            ]
        }
    }
}
