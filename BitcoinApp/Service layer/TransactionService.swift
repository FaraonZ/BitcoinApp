import Foundation

protocol TransactionService {
    func fetchTransactions(success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

final class TransactionServiceImpl: TransactionService {

    private let dataProvider: TransactionDataProvider = TransactionNetworkDataProvider()
    private let localStorage: TransactionsLocalStorage = TransactionsLocalStorageImpl()

    func fetchTransactions(success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        if localStorage.obtainTransaction().isEmpty {
            dataProvider.fetchTransactions { [weak self] transactions in
                self?.localStorage.save(transactions: transactions)
                success(transactions)
            } failure: { error in
                failure(error)
            }
        } else {
            success(localStorage.obtainTransaction())
        }
    }
}
