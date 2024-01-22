import CCLayout
import Combine
import UIKit
import UIKitUtil

final class CalculateCurrencyViewController: UIViewController {
    private let viewModel: CalculateCurrencyViewModel
    private let calculateCurrencyView = CalculateCurrencyView()
    private var subscription = Set<AnyCancellable>()

    init(viewModel: CalculateCurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        bindAction()
        bindState()
        viewModel.send(.viewDidLoad)
    }
}

private extension CalculateCurrencyViewController {
    func addView() {
        view.addSubviews(calculateCurrencyView)
    }

    func setLayout() {
        calculateCurrencyView.fillSuperview()
    }

    func bindAction() {
        calculateCurrencyView.recipientCountryChanged
            .map(CalculateCurrencyViewModel.Action.updateRecipientCountry)
            .sink(receiveValue: viewModel.send(_:))
            .store(in: &subscription)

        calculateCurrencyView.remittanceAmountChanged
            .map(CalculateCurrencyViewModel.Action.updateRemittanceAmount)
            .sink(receiveValue: viewModel.send(_:))
            .store(in: &subscription)
    }

    func bindState() {
        let sharedState = viewModel.$state.receive(on: DispatchQueue.main)

        sharedState
            .removeDuplicates { state1, state2 in
                state1.currency == state2.currency && state1.remittanceAmount == state2.remittanceAmount
            }
            .sink { [calculateCurrencyView] state in
                calculateCurrencyView.updateCurrency(currency: state.currency, country: state.recipientCountry)

                let amount: Double? = if let remittanceAmount = state.remittanceAmount {
                    Double(remittanceAmount) * state.currency
                } else {
                    nil
                }
                calculateCurrencyView.updateRemittanceAmount(
                    amount: amount,
                    country: state.recipientCountry
                )
            }
            .store(in: &subscription)

        sharedState.map(\.recipientCountry)
            .removeDuplicates()
            .sink(receiveValue: calculateCurrencyView.updateRecipientCountry(country:))
            .store(in: &subscription)

        sharedState.map(\.viewTimeDate)
            .removeDuplicates()
            .sink(receiveValue: calculateCurrencyView.updateViewTime(viewTime:))
            .store(in: &subscription)
    }
}
