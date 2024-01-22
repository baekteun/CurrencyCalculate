import CurrencyDomainTesting
import XCTest
@testable import CurrencyDomain

final class CurrencyRepositoryTests: XCTestCase {
    var remoteCurrencyDataSource: RemoteCurrencyDataSourceMock!
    var sut: CurrencyRepositoryImpl!

    override func setUp() {
        super.setUp()
        remoteCurrencyDataSource = .init()
        sut = CurrencyRepositoryImpl(remoteCurrencyDataSource: remoteCurrencyDataSource)
    }

    override func tearDown() {
        super.tearDown()
        remoteCurrencyDataSource = nil
        sut = nil
    }

    func test_FetchCurrency() async throws {
        let source = "USD"
        let target = "KRW"
        remoteCurrencyDataSource.fetchCurrencyHandler = { _, _ in
            1340
        }

        let result = try await sut.fetchCurrency(source: source, target: target)

        XCTAssertEqual(result, 1340)
    }
}
