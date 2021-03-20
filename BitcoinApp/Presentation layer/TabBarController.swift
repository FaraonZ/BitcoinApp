import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           
        let tabOne = TransactionsViewController()
        tabOne.title = "Transactions"
        tabOne.tabBarItem.image = UIImage(named: "transaction")
        
        let tabTwo = ConverterViewController()
        tabTwo.title = "Converter"
        tabTwo.tabBarItem.image = UIImage(named: "converter")
        
        self.setViewControllers([tabOne, tabTwo], animated: false)
    }
    
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
           
        }


}
