import CurrencyDomainTesting
import XCTest
@testable import CurrencyDomain

final class FetchCurrencyUseCaseTests: XCTestCase {
    var currencyRepository: CurrencyRepositoryMock!
    var sut: FetchCurrencyUseCaseImpl!

    override func setUp() {
        super.setUp()
        currencyRepository = .init()
        sut = FetchCurrencyUseCaseImpl(currencyRepository: currencyRepository)
    }

    override func tearDown() {
        super.tearDown()
        currencyRepository = nil
        sut = nil
    }

    func test_FetchCurrency() async throws {
        let source = "USD"
        let target = "KRW"
        currencyRepository.fetchCurrencyHandler = { _, _ in
            1340
        }

        let result = try await sut(source: source, target: target)

        XCTAssertEqual(result, 1340)
    }
}
