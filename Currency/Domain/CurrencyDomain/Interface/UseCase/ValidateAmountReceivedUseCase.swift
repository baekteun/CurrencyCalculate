public protocol ValidateAmountReceivedUseCase {
    func callAsFunction(amount: Double) -> Bool
}
