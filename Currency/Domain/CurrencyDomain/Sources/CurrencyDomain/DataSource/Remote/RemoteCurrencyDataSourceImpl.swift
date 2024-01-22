import CurrencyDomainInterface
import NetworkingInterface

final class RemoteCurrencyDataSourceImpl: RemoteCurrencyDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchCurrency(source: String, target: String) async throws -> Double {
        let currency = try await networking.request(
            CurrencyEndpoint.fetchCurrency(source: source, target: target),
            dto: FetchCurrencyResponseDTO.self
        )
        .toDomain(key: "\(source)\(target)")

        return currency ?? 0
    }
}
