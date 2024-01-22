import Foundation
import NetworkingInterface

public struct NetwokringComponent {
    public let requestable: any NetworkRequestable
    public let networking: any Networking

    public init() {
        self.requestable = URLSession.shared
        self.networking = NetworkingImpl(requestable: requestable)
    }
}
