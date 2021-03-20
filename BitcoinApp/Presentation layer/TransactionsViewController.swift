import SnapKit

final class TransactionsViewController: UIViewController {

    private var viewModel = TransactionsViewModel()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureIndicatorView()
        viewModel.fetchTransaction()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.didStartRequest = {
            self.activityIndicator.startAnimating()
        }
        viewModel.didEndRequest = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        viewModel.didGetError = { error in
            print(error)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: String(describing: TransactionTableViewCell.self))
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureIndicatorView() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: TransactionTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
        cell.amount_of_btcLable.text = viewModel.transactions[indexPath.row].amount + " BTC"
        let date = viewModel.transactions[indexPath.row].date
        cell.date_of_transactionLabel.text = timestamp_to_date(timeResult: date)
        let type = viewModel.transactions[indexPath.row].type
        cell.type_of_transactionLabel.text = type == 1 ? "sell" : "buy"
        return cell
    }
    
    func timestamp_to_date(timeResult: String) -> String {
        let date = Date(timeIntervalSince1970: Double(timeResult)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

extension TransactionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = DetailsViewController()
        let transaction = viewModel.transactions[indexPath.row]
        details.amount_of_btcLable.text =  details.amount_of_btcLable.text! + transaction.amount + " BTC"
        let date = timestamp_to_date(timeResult: transaction.date)
        details.date_of_transactionLabel.text =  details.date_of_transactionLabel.text! + date
        details.idLable.text =  details.idLable.text! + String(transaction.tid)
        details.priceLabel.text =  details.priceLabel.text! + transaction.price + " $"
        let total = Double(transaction.amount)! * Double(transaction.price)!
        details.totalLabel.text =  details.totalLabel.text! + String(format: "%.2f", total) + " $"
        present(details, animated: true, completion: nil)
    }
}
