import Foundation
import NetworkingInterface

extension Endpoint {
    func toRequest() throws -> URLRequest {
        let urlString = "\(self.baseURL)\(self.route.path)"
        guard let url = URL(
            string: urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        ),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else {
            throw NetworkingError.invalidURL
        }

        if let query {
            let queryItems = query.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlComponents.queryItems = queryItems
        }

        guard let requestURL = urlComponents.url else {
            throw NetworkingError.invalidURL
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = self.route.method
        request.allHTTPHeaderFields = self.header

        if let body, let httpBody = try? JSONEncoder().encode(body) {
            request.httpBody = httpBody
        }

        return request
    }
}
