public protocol CalculateCurrencyUseCase {
    func callAsFunction(lhs: Double, rhs: Double) -> Double
}
