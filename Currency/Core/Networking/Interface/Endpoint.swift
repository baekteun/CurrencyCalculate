import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var route: Route { get }
    var query: [String: String]? { get }
    var body: Encodable? { get }
    var validationCode: ClosedRange<Int> { get }
    var errorDict: [Int: Error]? { get }
    var header: [String: String]? { get }
}

public extension Endpoint {
    var query: [String: String]? { nil }
    var body: Encodable? { nil }
    var validationCode: ClosedRange<Int> { 200...299 }
    var errorDict: [Int: Error]? { nil }
    var header: [String: String]? { nil }
}

