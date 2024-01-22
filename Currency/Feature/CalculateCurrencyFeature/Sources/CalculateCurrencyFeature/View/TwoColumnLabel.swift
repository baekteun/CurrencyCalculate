import Then
import UIKit
import UIKitUtil

final class TwoColumnLabel: UIStackView {
    private let titleLabel = UILabel()
        .set(\.textAlignment, .right)
    private let separatorLabel = UILabel()
        .set(\.textAlignment, .center)
    private let valueLabel = UILabel()
        .set(\.textAlignment, .left)

    init(title: String, value: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.separatorLabel.text = ":"
        self.valueLabel.text = value

        self.addView()
        self.setLayout()
        self.configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateText(title: String? = nil, text: String? = nil) {
        if let title {
            self.titleLabel.text = title
        }

        if let text {
            self.valueLabel.text = text
        }
    }
}

private extension TwoColumnLabel {
    func addView() {
        self.addArrangedSubviews(titleLabel, separatorLabel, valueLabel)
    }

    func setLayout() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true

        self.separatorLabel.setWidth(4)
    }

    func configure() {
        self.distribution = .fill
        self.spacing = 8
    }
}
