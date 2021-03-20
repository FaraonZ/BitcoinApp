import Foundation

protocol TransactionsLocalStorage {
    func save(transactions: [Transaction])
    func obtainTransaction() -> [Transaction]
}

final class TransactionsLocalStorageImpl: TransactionsLocalStorage {
    func save(transactions: [Transaction]) {
        // todo: save transactions
    }

    func obtainTransaction() -> [Transaction] {
        // todo: obtain transactions
        return []
    }
}
