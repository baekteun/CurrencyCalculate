import Combine
import CurrencyDomainInterface
import Foundation

final class CalculateCurrencyViewModel {
    struct State {
        var recipientCountry: RecipientCountryType = .korea
        var remittanceAmount: Int?
        var viewTimeDate: Date = Date()
        var currency: Double = 0.0
    }
    enum Action {
        case viewDidLoad
        case updateRecipientCountry(country: RecipientCountryType)
        case updateRemittanceAmount(amount: Int?)
    }

    private let fetchCurrencyUseCase: any FetchCurrencyUseCase
    private let calculateCurrencyUseCase: any CalculateCurrencyUseCase
    private let validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase

    @Published private(set) var state = State()
    private var recipientCountryTask: Task<Void, Error>?

    init(
        fetchCurrencyUseCase: any FetchCurrencyUseCase,
        calculateCurrencyUseCase: any CalculateCurrencyUseCase,
        validateAmountReceivedUseCase: any ValidateAmountReceivedUseCase
    ) {
        self.fetchCurrencyUseCase = fetchCurrencyUseCase
        self.calculateCurrencyUseCase = calculateCurrencyUseCase
        self.validateAmountReceivedUseCase = validateAmountReceivedUseCase
    }

    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            viewDidLoad()

        case let .updateRecipientCountry(country):
            updateRecipientCountry(country: country)

        case let .updateRemittanceAmount(amount):
            updateRemittanceAmount(amount: amount)
        }
    }
}

private extension CalculateCurrencyViewModel {
    func viewDidLoad() {
        self.recipientCountryTask = Task {
            let currency = try await fetchCurrencyUseCase(
                source: "USD",
                target: state.recipientCountry.currencyString
            )
            self.state.viewTimeDate = Date()
            self.state.currency = currency
        }
    }

    func updateRecipientCountry(country: RecipientCountryType) {
        self.state.recipientCountry = country

        self.recipientCountryTask?.cancel()
        self.recipientCountryTask = nil

        self.recipientCountryTask = Task {
            let currency = try await fetchCurrencyUseCase(
                source: "USD",
                target: state.recipientCountry.currencyString
            )
            self.state.viewTimeDate = Date()
            self.state.currency = currency
        }
    }

    func updateRemittanceAmount(amount: Int?) {
        let amount: Int? = if let amount, validateAmountReceivedUseCase(amount: Double(amount)) {
            amount
        } else {
            nil
        }
        self.state.remittanceAmount = amount
    }
}
