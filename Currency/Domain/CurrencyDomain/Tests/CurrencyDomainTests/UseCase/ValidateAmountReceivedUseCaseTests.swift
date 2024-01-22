import CurrencyDomainTesting
import XCTest
@testable import CurrencyDomain

final class ValidateAmountReceivedUseCaseTests: XCTestCase {
    var sut: ValidateAmountReceivedUseCaseImpl!

    override func setUp() {
        super.setUp()
        sut = ValidateAmountReceivedUseCaseImpl()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_ValidateAmountReceived_valid_more_0() async throws {
        let result = sut(amount: 1)

        XCTAssertTrue(result)
    }

    func test_ValidateAmountReceived_valid_less_10_000() async throws {
        let result = sut(amount: 9999)

        XCTAssertTrue(result)
    }

    func test_ValidateAmountReceived_invalid_less_0() async throws {
        let result = sut(amount: -1)

        XCTAssertFalse(result)
    }

    func test_ValidateAmountReceived_invalid_more_10_000() async throws {
        let result = sut(amount: 10_001)

        XCTAssertFalse(result)
    }
}
