import Combine
import CurrencyDomainTesting
import XCTest
@testable import CalculateCurrencyFeature

final class CalculateCurrencyViewModelTests: XCTestCase {
    var fetchCurrencyUseCase: FetchCurrencyUseCaseMock!
    var calculateCurrencyUseCase: CalculateCurrencyUseCaseMock!
    var validateAmountReceivedUseCase: ValidateAmountReceivedUseCaseMock!
    var sut: CalculateCurrencyViewModel!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        self.fetchCurrencyUseCase = .init()
        self.calculateCurrencyUseCase = .init()
        self.validateAmountReceivedUseCase = .init()
        self.sut = .init(
            fetchCurrencyUseCase: fetchCurrencyUseCase,
            calculateCurrencyUseCase: calculateCurrencyUseCase,
            validateAmountReceivedUseCase: validateAmountReceivedUseCase
        )
        self.subscription = .init()
    }

    override func tearDown() {
        super.tearDown()
        self.fetchCurrencyUseCase = nil
        self.calculateCurrencyUseCase = nil
        self.validateAmountReceivedUseCase = nil
        self.sut = nil
        self.subscription = nil
    }

    func test_viewDidLoad_action() {
        let expectation = XCTestExpectation(description: "Currency fetched successfully")
        fetchCurrencyUseCase.handler = { _, _ in 1340 }
        let prevDate = sut.state.viewTimeDate

        sut.$state
            .filter { $0.currency > 0.0 }
            .sink { state in
                expectation.fulfill()
            }
            .store(in: &subscription)

        sut.send(.viewDidLoad)

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(fetchCurrencyUseCase.callCount, 1)
        XCTAssertEqual(sut.state.currency, 1340)
        XCTAssertTrue(prevDate < sut.state.viewTimeDate)
    }

    func test_updateRecipientCountry_action() {
        let expectation = XCTestExpectation(description: "Currency fetched successfully")
        fetchCurrencyUseCase.handler = { _, _ in 1340 }
        let prevDate = sut.state.viewTimeDate

        sut.$state
            .filter { $0.currency > 0.0 }
            .sink { state in
                expectation.fulfill()
            }
            .store(in: &subscription)

        sut.send(.updateRecipientCountry(country: .japan))

        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(fetchCurrencyUseCase.callCount, 1)
        XCTAssertEqual(sut.state.recipientCountry, .japan)
        XCTAssertEqual(sut.state.currency, 1340)
        XCTAssertTrue(prevDate < sut.state.viewTimeDate)
    }

    func test_updateRemittanceAmount_action_with_valid_amount() {
        validateAmountReceivedUseCase.handler = { _ in true }

        sut.send(.updateRemittanceAmount(amount: 23))

        XCTAssertEqual(sut.state.remittanceAmount, 23)
    }

    func test_updateRemittanceAmount_action_with_invalid_amount() {
        validateAmountReceivedUseCase.handler = { _ in false }

        sut.send(.updateRemittanceAmount(amount: 12_345))

        XCTAssertEqual(sut.state.remittanceAmount, nil)
    }

    func test_updateRemittanceAmount_action_with_amount_nil() {
        validateAmountReceivedUseCase.handler = { _ in false }

        sut.send(.updateRemittanceAmount(amount: nil))

        XCTAssertEqual(sut.state.remittanceAmount, nil)
    }
}

