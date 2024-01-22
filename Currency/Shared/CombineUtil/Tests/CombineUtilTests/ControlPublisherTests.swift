import Combine
@testable import CombineUtil
import XCTest

final class ControlPublisherTests: XCTestCase {
    var sut: UIButton!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        sut = UIButton()
        subscription = .init()
    }

    override func tearDown() {
        sut = nil
        subscription = nil
    }

    func test_CreateControlPublisher() throws {
        let sut = self.sut.controlPublisher(for: .touchUpOutside)

        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.control)
        XCTAssertEqual(sut.event, .touchUpOutside)
        XCTAssertEqual(self.sut.allControlEvents, [])
    }

    func test_SinglePublisher() throws {
        let sut = self.sut.controlPublisher(for: .touchUpInside)

        XCTAssertEqual(self.sut.allControlEvents, [])

        self.register(publisher: sut)

        XCTAssertEqual(self.sut.allControlEvents, .touchUpInside)
    }

    func test_MultiplePublisher() throws {
        let touchUpInside = self.sut.controlPublisher(for: .touchUpInside)
        let touchCancel = self.sut.controlPublisher(for: .touchCancel)

        XCTAssertEqual(self.sut.allControlEvents, [])

        self.register(publisher: touchUpInside)
        self.register(publisher: touchCancel)

        XCTAssertEqual(self.sut.allControlEvents, [.touchUpInside, .touchCancel])
    }

    func test_PublisherCancel() throws {
        let sut = self.sut.controlPublisher(for: .touchUpInside)
        self.register(publisher: sut)

        XCTAssertEqual(self.sut.allControlEvents, .touchUpInside)

        self.subscription.removeAll()

        XCTAssertEqual(self.sut.allControlEvents, [])
    }

    private func register(publisher: UIControl.EventPublisher) {
        publisher
            .sink(receiveValue: { _ in })
            .store(in: &self.subscription)
    }
}
