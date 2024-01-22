import CCLayout
import XCTest

final class CCLayoutTests: XCTestCase {
    var containerView: UIView!
    var subview: UIView!

    override func setUp() {
        super.setUp()
        containerView = UIView(frame: .init(x: 20, y: 20, width: 40, height: 40))
        subview = UIView()
        containerView.addSubview(subview)
    }

    override func tearDown() {
        super.tearDown()
        containerView = nil
        subview = nil
    }

    func test_DimensionConstraints() throws {
        let constant: CGFloat = 20
        containerView.frame = .init(x: 0, y: 0, width: constant, height: constant)

        subview.setDimensions(height: constant, width: constant)
        containerView.layoutIfNeeded()

        let widthConstraint = try XCTUnwrap(
            subview.constraints.filter({ $0.firstAnchor == subview.widthAnchor }).first
        )

        let heightConstraint = try XCTUnwrap(
            subview.constraints.filter({ $0.firstAnchor == subview.heightAnchor }).first
        )

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(subview.frame, containerView.frame)
        XCTAssertEqual(subview.constraints.count, 2)
        XCTAssertEqual(widthConstraint.constant, constant)
        XCTAssertEqual(heightConstraint.constant, constant)
    }

    func test_BottomConstraints() {
        containerView.layoutIfNeeded()
        XCTAssertEqual(containerView.constraints.count, 0)

        subview.setAnchor(bottom: containerView.bottomAnchor)
        containerView.layoutIfNeeded()

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(containerView.constraints.count, 1)
    }

    func test_TopLeadingConstraints() {
        containerView.layoutIfNeeded()
        XCTAssertEqual(containerView.constraints.count, 0)

        subview.setAnchor(top: containerView.topAnchor, leading: containerView.leadingAnchor)
        containerView.layoutIfNeeded()

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(containerView.constraints.count, 2)
    }

    func test_BottomTrailingConstraintsWithConstant() throws {
        containerView.layoutIfNeeded()
        XCTAssertEqual(containerView.constraints.count, 0)

        let consant: CGFloat = 30
        subview.setAnchor(
            bottom: containerView.bottomAnchor,
            paddingBottom: consant,
            trailing: containerView.trailingAnchor,
            paddingTrailing: consant
        )
        containerView.layoutIfNeeded()
        let bottomConstraint = try XCTUnwrap(
            containerView.constraints.filter({ $0.firstAnchor == subview.bottomAnchor }).first
        )
        let trailingConstraint = try XCTUnwrap(
            containerView.constraints.filter({ $0.firstAnchor == subview.trailingAnchor }).first
        )

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(containerView.constraints.count, 2)
        XCTAssertEqual(
            bottomConstraint.constant,
            -consant,
            "Bottom padding is not set or negative"
        )
        XCTAssertEqual(
            trailingConstraint.constant,
            -consant,
            "Trailing padding is not set or negative"
        )
    }

    func test_TopLeadingConstraintsWithConstant() throws {
        containerView.layoutIfNeeded()
        XCTAssertEqual(containerView.constraints.count, 0)

        let consant: CGFloat = 30
        subview.setAnchor(
            top: containerView.topAnchor,
            paddingTop: consant,
            leading: containerView.leadingAnchor,
            paddingLeading: consant
        )
        containerView.layoutIfNeeded()

        let topConstraint = try XCTUnwrap(
            containerView.constraints.filter({ $0.firstAnchor == subview.topAnchor }).first
        )

        let leadingConstraint = try XCTUnwrap(
            containerView.constraints.filter({ $0.firstAnchor == subview.leadingAnchor }).first
        )

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(containerView.constraints.count, 2)
        XCTAssertEqual(
            topConstraint.constant,
            consant,
            "Top padding is not set or positive"
        )
        XCTAssertEqual(
            leadingConstraint.constant,
            consant,
            "Leading padding is not set or positive"
        )
    }

    func test_FillSuperviewConstraints() {
        containerView.layoutIfNeeded()
        XCTAssertEqual(containerView.constraints.count, 0)

        subview.fillSuperview()
        containerView.layoutIfNeeded()

        XCTAssertEqual(subview.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(containerView.constraints.count, 4)
    }
}
