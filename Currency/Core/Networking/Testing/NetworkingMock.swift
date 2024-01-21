import NetworkingInterface

public final class NetworkingMock: Networking {
    public init() {}

    public private(set) var dtoRequestCallCount = 0
    public var dtoRequestHandler: ((Endpoint, Decodable.Type) async throws -> Decodable)?
    public func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T {
        dtoRequestCallCount += 1
        guard let handler = dtoRequestHandler,
            let response = try await handler(endpoint, dto.self) as? T else {
            fatalError("Handler not implemented")
        }
        return response
    }

    public private(set) var requestCallCount = 0
    public var requestHandler: ((Endpoint) async throws -> Void)?
    public func request(_ endpoint: Endpoint) async throws {
        requestCallCount += 1
        guard let handler = requestHandler else {
            fatalError("Handler not implemented")
        }
        try await handler(endpoint)
    }
}
