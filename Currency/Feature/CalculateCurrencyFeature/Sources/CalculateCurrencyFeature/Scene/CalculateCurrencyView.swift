import Combine
import CurrencyDomainInterface
import UIKit

protocol CalculateCurrencyActionProtocol {
    var recipientCountryChanged: AnyPublisher<RecipientCountryType, Never> { get }
    var remittanceAmountChanged: AnyPublisher<Int?, Never> { get }
}

protocol CalculateCurrencyStateProtocol {
    func updateRecipientCountry(country: RecipientCountryType)
    func updateCurrency(currency: Double, country: RecipientCountryType)
    func updateViewTime(viewTime: Date)
    func updateRemittanceAmount(amount: Double?, country: RecipientCountryType)
}

final class CalculateCurrencyView: UIView {
    private enum Metric {
        static let labelSpacing: CGFloat = 8
        static let horizontalPadding: CGFloat = 16
    }

    private let titleLabel = UILabel()
        .set(\.text, "환율 계산")
        .set(\.font, .systemFont(ofSize: 40))
    private let remittanceCountryLabel = TwoColumnLabel(title: "송금국가", value: "미국 (USD)")
    private let recipientCountryLabel = TwoColumnLabel(title: "수취국가", value: "한국 (KRW)")
    private let currencyLabel = TwoColumnLabel(title: "환율", value: "0.00 KRW / USD")
    private let viewTimeLabel = TwoColumnLabel(title: "조회시간", value: "2023-01-23 00:00")
    private let remittanceAmountTextField = TwoColumnTextField(title: "송금액", value: "USD")
    private let labelStackView = UIStackView()
        .set(\.axis, .vertical)
        .set(\.spacing, Metric.labelSpacing)
    private let recipientAmountLabel = UILabel()
        .set(\.text, "송금액이 바르지 않습니다.")
        .set(\.textAlignment, .center)
        .set(\.numberOfLines, 0)
        .set(\.font, .systemFont(ofSize: 22))
    private let recipientCountryPicker = UIPickerView()

    private let recipientCountryChangedSubject = PassthroughSubject<RecipientCountryType, Never>()

    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalculateCurrencyView: CalculateCurrencyActionProtocol {
    var recipientCountryChanged: AnyPublisher<RecipientCountryType, Never> {
        recipientCountryChangedSubject.eraseToAnyPublisher()
    }

    var remittanceAmountChanged: AnyPublisher<Int?, Never> {
        remittanceAmountTextField.inputChanged
            .map(Int.init)
            .eraseToAnyPublisher()
    }
}

extension CalculateCurrencyView: CalculateCurrencyStateProtocol {
    func updateRecipientCountry(country: RecipientCountryType) {
        let text = "\(country.countryString) (\(country.currencyString))"
        recipientCountryLabel.updateText(text: text)
    }

    func updateCurrency(currency: Double, country: RecipientCountryType) {
        guard let currencyString = currency.toCurrencyString() else {
            return
        }
        self.currencyLabel.updateText(text: "\(currencyString) (\(country.currencyString)) / USD")
    }
    
    func updateViewTime(viewTime: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let dateString = dateFormatter.string(from: viewTime)
        self.viewTimeLabel.updateText(text: dateString)
    }

    func updateRemittanceAmount(amount: Double?, country: RecipientCountryType) {
        if let amount, let amountString = amount.toCurrencyString() {
            recipientAmountLabel.text = "수취금액은 \(amountString) (\(country.currencyString)) 입니다"
        } else {
            recipientAmountLabel.text = "송금액이 바르지 않습니다."
        }
    }
}

private extension CalculateCurrencyView {
    func addView() {
        self.addSubviews(titleLabel, labelStackView, recipientAmountLabel, recipientCountryPicker)
        self.labelStackView.addArrangedSubviews(
            remittanceCountryLabel,
            recipientCountryLabel,
            currencyLabel,
            viewTimeLabel,
            remittanceAmountTextField
        )
    }

    func setLayout() {
        let horizontalLayoutGuide = UILayoutGuide()
        self.addLayoutGuide(horizontalLayoutGuide)

        horizontalLayoutGuide.leadingAnchor.constraint(
            equalTo: self.leadingAnchor,
            constant: Metric.horizontalPadding
        ).isActive = true
        horizontalLayoutGuide.trailingAnchor.constraint(
            equalTo: self.trailingAnchor,
            constant: -Metric.horizontalPadding
        ).isActive = true

        self.titleLabel.setCenterX(view: self, topAnchor: self.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        self.labelStackView.setAnchor(
            top: titleLabel.bottomAnchor,
            paddingTop: 16,
            leading: horizontalLayoutGuide.leadingAnchor,
            trailing: horizontalLayoutGuide.trailingAnchor
        )
        self.recipientAmountLabel.setAnchor(
            top: labelStackView.bottomAnchor,
            paddingTop: 32,
            leading: horizontalLayoutGuide.leadingAnchor,
            trailing: horizontalLayoutGuide.trailingAnchor
        )
        self.recipientCountryPicker.setAnchor(
            leading: horizontalLayoutGuide.leadingAnchor,
            bottom: self.safeAreaLayoutGuide.bottomAnchor,
            paddingBottom: -16,
            trailing: horizontalLayoutGuide.trailingAnchor
        )
    }

    func configure() {
        self.backgroundColor = .white
        self.remittanceAmountTextField.setKeyboardType(type: .numberPad)
        self.recipientCountryPicker.delegate = self
        self.recipientCountryPicker.dataSource = self
    }
}

extension CalculateCurrencyView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        RecipientCountryType.allCases.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        let recipientCountry = RecipientCountryType.allCases[row]
        return "\(recipientCountry.countryString) (\(recipientCountry.currencyString))"
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        let recipientCountry = RecipientCountryType.allCases[row]
        recipientCountryChangedSubject.send(recipientCountry)
    }
}
