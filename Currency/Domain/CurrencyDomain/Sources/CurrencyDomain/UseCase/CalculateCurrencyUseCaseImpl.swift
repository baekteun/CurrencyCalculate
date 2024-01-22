import CurrencyDomainInterface

final class CalculateCurrencyUseCaseImpl: CalculateCurrencyUseCase {
    func callAsFunction(lhs: Double, rhs: Double) -> Double {
        lhs * rhs
    }
}
