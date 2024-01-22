import Foundation

struct FetchCurrencyResponseDTO: Decodable {
    let quotes: [String: Double]
}

extension FetchCurrencyResponseDTO {
    func toDomain(key: String) -> Double? {
        self.quotes[key]
    }
}
