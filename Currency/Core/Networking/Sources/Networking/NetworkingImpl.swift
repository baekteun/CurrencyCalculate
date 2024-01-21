import Foundation
import NetworkingInterface

final class NetworkingImpl: Networking {
    private let requestable: any NetworkRequestable

    init(requestable: any NetworkRequestable) {
        self.requestable = requestable
    }

    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T {
        let data = try await performRequest(endpoint: endpoint)
        return try JSONDecoder().decode(dto.self, from: data)
    }

    func request(_ endpoint: Endpoint) async throws {
        try await performRequest(endpoint: endpoint)
    }
}

private extension NetworkingImpl {
    @discardableResult
    func performRequest(endpoint: Endpoint) async throws -> Data {
        do {
            let request = try endpoint.toRequest()
            let (data, response) = try await requestable.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.noResponse
            }
            guard endpoint.validationCode ~= httpResponse.statusCode else {
                throw StatusError(statusCode: httpResponse.statusCode)
            }

            return data
        } catch {
            guard let errorDict = endpoint.errorDict,
                  let statusError = error as? StatusError,
                  let endpointError = errorDict[statusError.statusCode]
            else {
                throw error
            }
            throw endpointError
        }
    }
}
