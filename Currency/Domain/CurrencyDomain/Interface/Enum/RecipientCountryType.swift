import Foundation

public enum RecipientCountryType: String, CaseIterable {
    case korea
    case japan
    case philippines
}

public extension RecipientCountryType {
    var currencyString: String {
        switch self {
        case .korea: "KRW"
        case .japan: "JPY"
        case .philippines: "PHP"
        }
    }

    var countryString: String {
        switch self {
        case .korea: "한국"
        case .japan: "일본"
        case .philippines: "필리핀"
        }
    }
}
