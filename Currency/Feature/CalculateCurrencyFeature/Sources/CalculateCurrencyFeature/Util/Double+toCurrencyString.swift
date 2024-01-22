import Foundation

extension Double {
    func toCurrencyString() -> String? {
        let numberFormatter = NumberFormatter().then {
            $0.numberStyle = .decimal
            $0.minimumFractionDigits = 2
            $0.maximumFractionDigits = 2
        }
        
        guard let currency = numberFormatter.string(from: NSNumber(value: self)) else {
            return nil
        }
        return currency
    }
}
