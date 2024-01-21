import XCTest
import Foundation
import NetworkingInterface
import NetworkingTesting
@testable import Networking

final class NetworkingImplTests: XCTestCase {
    var requestable: NetworkRequestableMock!
    var networking: NetworkingImpl!

    override func setUp() {
        requestable = .init()
        networking = .init(requestable: requestable)
    }

    override func tearDown() {
        requestable = nil
        networking = nil
    }

    func test_DTORequest_WithValidResponse() async throws {
        let responseData = "{\"key\":\"value\"}".data(using: .utf8)!
        let response = HTTPURLResponse(
            url: URL(string: "http://localhost:8080")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        requestable.dataHandler = { _ in
            return (responseData, response)
        }

        let endpoint = SampleEndpoint.sample
        let result: SampleDTO = try await networking.request(endpoint, dto: SampleDTO.self)

        XCTAssertEqual(requestable.dataCallCount, 1)
        XCTAssertEqual(result.key, "value")
    }

    func test_DTORequest_WithInvalidResponse() async throws {
        let responseData = "{\"error\":\"Invalid Request\"}".data(using: .utf8)!
        let response = HTTPURLResponse(
            url: URL(string: "http://localhost:8080")!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )!
        requestable.dataHandler = { _ in
            return (responseData, response)
        }

        let endpoint = SampleEndpoint.sample

        do {
            _ = try await networking.request(endpoint, dto: SampleDTO.self)
            XCTAssertEqual(requestable.dataCallCount, 1)
            XCTFail("Request not failed")
        } catch {
            XCTAssertTrue(error is StatusError)
        }
    }

    func test_Request_WithNoResponse() async throws {
        let response = HTTPURLResponse(
            url: URL(string: "http://localhost:8080")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        requestable.dataHandler = { _ in
            return (.init(), response)
        }

        let endpoint = SampleEndpoint.sample

        try await networking.request(endpoint)
    }
}

struct SampleDTO: Codable {
    let key: String
}

enum SampleEndpoint: Endpoint {
    case sample

    var baseURL: String { "http://localhost:8080" }
    var route: Route { .get("/sample") }
}
