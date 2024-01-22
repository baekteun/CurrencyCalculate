import CurrencyDomainTesting
import XCTest
@testable import CurrencyDomain

final class CalculateCurrencyUseCaseTests: XCTestCase {
    var sut: CalculateCurrencyUseCaseImpl!

    override func setUp() {
        super.setUp()
        sut = CalculateCurrencyUseCaseImpl()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_CalculateCurrency() async throws {
        let result = sut(lhs: 1, rhs: 1340.0)

        XCTAssertEqual(result, 1340.0)
    }
}
