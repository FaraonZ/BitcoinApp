import UIKit

class DetailsViewController: UIViewController {
    
    let date_of_transactionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Date of transaction: "
        return label
    }()
    
    let amount_of_btcLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Amount of bitcoin: "
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Bitcoin to dollar rate: "
        return label
    }()
    
    let idLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "ID of transaction: "
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Total for transaction: "
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Converter"
        layoutUI()
    }
    
    
    private func layoutUI() {
        configureDate_of_transactionLabel()
        configureAmount_of_btcLable()
        configurePrriceLabel()
        configureIdLable()
        configureTotalLabel()
    }

    
    private func configureDate_of_transactionLabel() {
        view.addSubview(date_of_transactionLabel)
        date_of_transactionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
        }
    }

    private func configureAmount_of_btcLable() {
        view.addSubview(amount_of_btcLable)
        amount_of_btcLable.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(date_of_transactionLabel.snp.bottom).offset(20)
        }
    }
    
    private func configurePrriceLabel() {
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(amount_of_btcLable.snp.bottom).offset(20)
        }
    }

    private func configureIdLable() {
        view.addSubview(idLable)
        idLable.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
        }
    }

    private func configureTotalLabel() {
        view.addSubview(totalLabel)
        totalLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(idLable.snp.bottom).offset(20)
        }
    }
}
