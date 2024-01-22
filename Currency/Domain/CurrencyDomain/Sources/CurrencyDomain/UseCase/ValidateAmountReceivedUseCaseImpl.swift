import CurrencyDomainInterface

final class ValidateAmountReceivedUseCaseImpl: ValidateAmountReceivedUseCase {
    func callAsFunction(amount: Double) -> Bool {
        0 < amount && amount < 10_000
    }
}
