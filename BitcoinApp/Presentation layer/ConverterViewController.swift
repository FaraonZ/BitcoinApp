import UIKit

class ConverterViewController: UIViewController {
    
    var selectedCurency: String?
    var selectedCurency2: String?
    var curencyList = ["USD", "EUR", "KZT", "BTC"]
    
    var list = [Currency]()
    
    private var FromPickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    private var ToPickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()

    private var FromTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Curency From"
        tf.layer.borderWidth = 2
        return tf
    }()
    
    private var ToTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Cureency To"
        tf.layer.borderWidth = 2
        return tf
    }()
    
    private var EnterValueTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter value"
        tf.layer.borderWidth = 1.5
        return tf
    }()
    
    private var ConvertedValueTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.5
        return tf
    }()
    
    let lable1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Conferting From this"
        return label
    }()
    
    let lable2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "To this"
        return label
    }()
    
    let convertButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.setTitle("Convert", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1.5
        btn.addTarget(self, action: #selector(convertAction), for: .touchUpInside)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        FromPickerView.dataSource = self
        FromPickerView.delegate = self
        ToPickerView.dataSource = self
        ToPickerView.delegate = self
        
        layoutUI()
    }
    
    private func layoutUI() {
        configureFromTextField()
        configureToTextField()
        configureEnterValueTextField()
        configureConvertedValueTextField()
        configureLable1()
        configureLabel2()
        configureConvertButton()
    }
    
    
    
    
    private func configureLable1() {
        view.addSubview(lable1)
        lable1.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(120)
        }
    }
    private func configureLabel2() {
        view.addSubview(lable2)
        lable2.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-135)
            $0.top.equalToSuperview().offset(120)
        }
    }
    
    private func configureFromTextField() {
        FromTextField.inputView = FromPickerView
        FromTextField.textAlignment = .center
        FromPickerView.tag = 1
        view.addSubview(FromTextField)
        FromTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(150)
            $0.width.equalTo(150)
            
        }
    }
    
    private func configureToTextField() {
        ToTextField.inputView = ToPickerView
        ToTextField.textAlignment = .center
        FromPickerView.tag = 2
        view.addSubview(ToTextField)
        ToTextField.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(150)
            $0.width.equalTo(150)
        }
    }
    
    private func configureEnterValueTextField() {
        EnterValueTextField.textAlignment = .center
        view.addSubview(EnterValueTextField)
        EnterValueTextField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(200)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
    }
    
    private func configureConvertedValueTextField() {
        ConvertedValueTextField.textAlignment = .center
        view.addSubview(ConvertedValueTextField)
        ConvertedValueTextField.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(200)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
    }
    
    private func configureConvertButton() {
        view.addSubview(convertButton)
        convertButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(165)
            $0.top.equalToSuperview().offset(250)
            $0.width.equalTo(80)
        }
    }
    
    
    
    @objc func convertAction(sender: UIButton){
        getData()
        getData2()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let enter = Int(self.EnterValueTextField.text!)!
            self.convert(entered: Double(enter), from: self.selectedCurency!, to: self.selectedCurency2!)
        }
    }
    
    
    func getData() {
        
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/KZT.json")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        DispatchQueue.main.async {
                            let array = Array(jsonResponse["bpi"] as! Dictionary<String,AnyObject>)
                            for value in array {
                                let code = value.value["code"] as! String
                                let value = value.value["rate_float"] as! Double
                                self.list.append(Currency(code: code, value: value))
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    
    func getData2() {
        
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        DispatchQueue.main.async {
                            let array = Array(jsonResponse["bpi"] as! Dictionary<String,AnyObject>)
                            for value in array {
                                let code = value.value["code"] as! String
                                let value = value.value["rate_float"] as! Double
                                if code == "EUR"{
                                    self.list.append(Currency(code: code, value: value))
                                    break
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }

    
    private func convert(entered: Double, from: String, to: String){
        if from == "BTC"{
            switch to {
            case "EUR":
                var eur = 0.0
                for val in list{
                    if val.code == "EUR"{
                        eur = val.value
                    }
                }
                let value = String(format: "%.2f", entered * eur)
                ConvertedValueTextField.text = value
            case "KZT":
                var kzt = 0.0
                for val in list{
                    if val.code == "KZT"{
                        kzt = val.value
                    }
                }
                let value = String(format: "%.2f",entered * kzt)
                ConvertedValueTextField.text = value
            case "USD":
                var usd = 0.0
                for val in list{
                    if val.code == "USD"{
                        usd = val.value
                    }
                }
                let value = String(format: "%.2f", entered * usd)
                ConvertedValueTextField.text = value
            default:
                break
            }
        }
        
        if from == "EUR"{
            switch to {
            case "BTC":
                var eur = 0.0
                for val in list{
                    if val.code == "EUR"{
                        eur = val.value
                    }
                }
                let value = String(format: "%.8f", 1.0 / eur)
                print(value)
                ConvertedValueTextField.text = value
            case "KZT":
                var kzt = 0.0
                var eur = 0.0
                for val in list{
                    if val.code == "KZT"{
                        kzt = val.value
                    }
                    if val.code == "EUR"{
                        eur = val.value
                    }
                }
                let value = String(format: "%.2f", kzt / eur)
                ConvertedValueTextField.text = value
            case "USD":
                var usd = 0.0
                var eur = 0.0
                for val in list{
                    if val.code == "USD"{
                        usd = val.value
                    }
                    if val.code == "EUR"{
                        eur = val.value
                    }
                }
                let value = String(format: "%.2f", usd / eur)
                ConvertedValueTextField.text = value
            default:
                break
            }
        }
    }
}

extension ConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return curencyList.count
        }
        return curencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return curencyList[row]
        }
        return curencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == FromPickerView{
            selectedCurency = curencyList[row]
            FromTextField.text = selectedCurency
            FromTextField.endEditing(true)
        }
        else{
            selectedCurency2 = curencyList[row]
            ToTextField.text = selectedCurency2
            ToTextField.endEditing(true)
        }
    }
    
}
