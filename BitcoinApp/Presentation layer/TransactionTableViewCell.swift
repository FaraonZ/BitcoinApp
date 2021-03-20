import SnapKit

final class TransactionTableViewCell: UITableViewCell {

    let date_of_transactionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let amount_of_btcLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let type_of_transactionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUI() {
        configureDate_of_transactionLabel()
        configureAmount_of_btcLable()
        configureType_of_transactionLabel()
    }

    private func configureDate_of_transactionLabel() {
        contentView.addSubview(date_of_transactionLabel)
        date_of_transactionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(5)
        
        }
    }

    private func configureAmount_of_btcLable() {
        contentView.addSubview(amount_of_btcLable)
        amount_of_btcLable.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(date_of_transactionLabel.snp.bottom).offset(10)
            $0.width.equalTo(200)
        }
    }

    private func configureType_of_transactionLabel() {
        contentView.addSubview(type_of_transactionLabel)
        type_of_transactionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalTo(amount_of_btcLable.snp.right).offset(130)
        }
    }
}
