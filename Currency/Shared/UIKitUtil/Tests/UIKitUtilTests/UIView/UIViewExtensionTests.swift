import UIKit
import UIKitUtil
import XCTest

final class UIViewExtensionTests: XCTestCase {
    var sut: UIView!

    override func setUp() {
        super.setUp()
        sut = UIView()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_UIView_addSubviews() {
        let aView = UIView()
        let bView = UIView()

        sut.addSubviews(aView, bView)

        XCTAssertEqual(sut.subviews, [aView, bView])
    }
}
