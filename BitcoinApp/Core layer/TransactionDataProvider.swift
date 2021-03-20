import Foundation

protocol TransactionDataProvider {
    func fetchTransactions(success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void)
}

final class TransactionNetworkDataProvider: TransactionDataProvider {
    func fetchTransactions(success: @escaping ([Transaction]) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = "https://www.bitstamp.net/api/transactions"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                failure(error)
            } else if let data = data {
                do {
                    let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                    DispatchQueue.main.async {
                        success(transactions)
                    }
                } catch {
                    failure(error)
                }
            }
        }.resume()
    }
}
