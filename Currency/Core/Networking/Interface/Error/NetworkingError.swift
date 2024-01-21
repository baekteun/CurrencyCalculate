import Foundation

public enum NetworkingError: Error {
    case invalidURL
    case noResponse
    case underlying(Error)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is invalid"

        case .noResponse:
            return "No response"

        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
