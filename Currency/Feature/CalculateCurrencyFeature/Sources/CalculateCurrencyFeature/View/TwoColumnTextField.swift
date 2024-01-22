import Combine
import CombineUtil
import UIKit
import UIKitUtil

protocol TwoColumnTextFieldActionProtocol {
    var inputChanged: AnyPublisher<String, Never> { get }
}

final class TwoColumnTextField: UIStackView {
    private let titleLabel = UILabel()
        .set(\.textAlignment, .right)
    private let separatorLabel = UILabel()
        .set(\.textAlignment, .center)
    private let inputTextField = UITextField()
        .set(\.borderStyle, .line)
        .set(\.textAlignment, .right)
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

    public func setKeyboardType(type: UIKeyboardType) {
        self.inputTextField.keyboardType = type
    }
}

extension TwoColumnTextField: TwoColumnTextFieldActionProtocol {
    var inputChanged: AnyPublisher<String, Never> {
        inputTextField.textPublisher.eraseToAnyPublisher()
    }
}

private extension TwoColumnTextField {
    func addView() {
        self.addArrangedSubviews(titleLabel, separatorLabel, inputTextField, valueLabel)
    }

    func setLayout() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true

        self.separatorLabel.setWidth(4)

        self.inputTextField.translatesAutoresizingMaskIntoConstraints = false
        self.inputTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    }

    func configure() {
        self.distribution = .fill
        self.spacing = 8
    }
}
