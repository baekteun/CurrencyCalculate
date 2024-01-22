import UIKit
import UIKitUtil
import XCTest

final class UIStackViewExtensionTests: XCTestCase {
    var sut: UIStackView!

    override func setUp() {
        super.setUp()
        sut = UIStackView()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_UIStackView_addArrangedSubviews() {
        let aView = UIView()
        let bView = UIView()

        sut.addArrangedSubviews(aView, bView)

        XCTAssertEqual(sut.arrangedSubviews, [aView, bView])
    }
}
