import Foundation
import NetworkingInterface

public final class NetworkRequestableMock: NetworkRequestable {
    public init() {}

    public private(set) var dataCallCount = 0
    public var dataHandler: ((URLRequest) async throws -> (Data, URLResponse))?

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let dataHandler else {
            fatalError("Hanlder not implemented")
        }
        dataCallCount += 1
        return try await dataHandler(request)
    }
}
