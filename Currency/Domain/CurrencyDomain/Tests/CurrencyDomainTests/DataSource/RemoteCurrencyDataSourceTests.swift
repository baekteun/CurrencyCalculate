import NetworkingInterface
import NetworkingTesting
import XCTest
@testable import CurrencyDomain

final class RemoteCurrencyDataSourceTests: XCTestCase {
    var networkingMock: NetworkingMock!
    var sut: RemoteCurrencyDataSourceImpl!

    override func setUp() {
        super.setUp()
        networkingMock = NetworkingMock()
        sut = RemoteCurrencyDataSourceImpl(networking: networkingMock)
    }

    override func tearDown() {
        super.tearDown()
        networkingMock = nil
        sut = nil
    }

    func test_FetchCurrency() async throws {
        let source = "USD"
        let target = "KRW"
        let responseDTO = FetchCurrencyResponseDTO(
            quotes: ["USDKRW": 1340]
        )
        networkingMock.dtoRequestHandler = { _, _ in
            responseDTO
        }
        let result = try await sut.fetchCurrency(source: source, target: target)

        XCTAssertEqual(result, 1340)
    }
}
