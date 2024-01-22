import Combine
import XCTest
@testable import CombineUtil

final class UITextFieldTextPublisherTests: XCTestCase {
    var sut: UITextField!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        sut = .init()
        subscription = .init()
    }

    override func tearDown() {
        sut = nil
        subscription = nil
    }

    func test_UIButtonTapPublisher() {
        let control = self.sut.textPublisher

        XCTAssertEqual(self.sut.allControlEvents, [])

        control.sink { _ in }
            .store(in: &subscription)

        XCTAssertEqual(self.sut.allControlEvents, [.editingChanged])
    }
}

