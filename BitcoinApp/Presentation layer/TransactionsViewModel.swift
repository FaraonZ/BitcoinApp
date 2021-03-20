import Foundation

final class TransactionsViewModel {
    var didStartRequest: () -> Void = { }
    var didEndRequest: () -> Void = { }
    var didGetError: (Error) -> Void = { _ in }
    private(set) var transactions: [Transaction] = []
    private let transactionService: TransactionService = TransactionServiceImpl()

    func fetchTransaction() {
        didStartRequest()
        transactionService.fetchTransactions { [weak self] transactions in
            for item in 1...499 {
                self?.transactions.append(transactions[item])
            }
            self?.didEndRequest()
        } failure: { [weak self] error in
            self?.didGetError(error)
        }
    }
}
