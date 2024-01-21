import Foundation

public protocol Networking {
    func request<T: Decodable>(_ endpoint: any Endpoint, dto: T.Type) async throws -> T
    func request(_ endpoint: any Endpoint) async throws
}

