//
//  OrdersViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/31/21.
//

import UIKit

class OrdersViewController: UIViewController {
    static var inst = OrdersViewController()
    static var currentOrderArray: [currentOrder] = []
    @IBOutlet weak var mainView: UIScrollView!
    var subviewSize = 0
        let ud = UserDefaults.standard
        var user : User?
        var prod : Product?
    static var boughtItems : [BoughtProduct]? = []
    static func displayCurrentOrder(){
        OrdersViewController.currentOrderArray = []
        let ud2 = UserDefaults.standard
        let user2 = DBHelper.inst.fetchUser(query: ud2.string(forKey: "currUser")!)
        var prod : Product?
        boughtItems = DBHelper.inst.fetchBoughtProduct(uName: ud2.string(forKey: "currUser")!)
        for item in boughtItems!{
            OrdersViewController.currentOrderArray.append(currentOrder(name: item.name!, price: String(format: "$%.2f", item.price), pImage: item.image!, pTracking: item.trackingStatus!, itemTag: item.bProdID!))
            
        }
        
    }
    
    class currentOrder : CustomView{
        let ud = UserDefaults.standard
        var prod : Product?
        var currentOrderItemName: String
        var currentOrderPrice: String
        var prodImage : String
        init(name: String, price: String, pImage : String, pTracking : String, itemTag : String) {
                currentOrderItemName = name
                currentOrderPrice = price
                prodImage = pImage
                super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
                let title = UILabel(frame: CGRect(x: 150, y: 10, width: 200, height: 50))
                title.numberOfLines = 0
                title.text = currentOrderItemName
                self.addSubview(title)
                let image = UIImageView(image:UIImage(named: prodImage))
                image.frame = CGRect(x: 10, y: 22.5, width: 120, height: 100)
                image.contentMode = .scaleAspectFit
                image.clipsToBounds = true
                self.addSubview(image)
                let price = UILabel()
                price.text = (String(currentOrderPrice))
                price.frame = CGRect(x: 300, y: 90, width: 100, height: 20)
                self.addSubview(price)
                let tracking = UILabel(frame: CGRect(x: 150, y: 70, width: 200, height: 40))
            tracking.numberOfLines = 0
            tracking.text = "Status: " + pTracking
            tracking.font = UIFont(name: "arial", size: 15)
            self.addSubview(tracking)
            let refund = CustomButton(frame: CGRect(x: 290, y: 45, width: 80, height: 40))
            refund.setTitle("Refund", for: .normal)
            refund.tag = Int(itemTag)!
            refund.addTarget(self, action: #selector(getRefund), for: .touchUpInside)
            
            self.addSubview(refund)
            
                title.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        @objc func getRefund(sender: UIButton){
            DBHelper.inst.refundProduct(boughtProdID: String(sender.tag), uName:  ud.string(forKey: "currUser")!)
            OrdersViewController.inst.closeView()
            
        }

    }
    func closeView(){
        let sb = UIStoryboard(name: "Payment", bundle: nil)
        let current = sb.instantiateViewController(withIdentifier: "Order") as! OrdersViewController
        current.modalPresentationStyle = .fullScreen
        present(current, animated: true, completion: nil)
    }
    func configureSubView(){
        addCurrentOrderToSubViews()
        
    }
    override func viewDidAppear(_ animated: Bool) {

        if(OrdersViewController.boughtItems!.count == 0){
            let alert = UIAlertController(title: "Your current orders are empty.", message: "Your current orders is currently empty, please buy some items.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            OrdersViewController.inst.present(alert, animated: true)
            return
        }
    }
    override func viewDidLoad() {//        testCart()
        
        super.viewDidLoad()
        
        OrdersViewController.inst = self
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        

        
        OrdersViewController.displayCurrentOrder()
        if(OrdersViewController.boughtItems!.count == 0){
            let alert = UIAlertController(title: "Your current order list is empty.", message: "Your current order list is currently empty, please buy some items.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            OrdersViewController.inst.present(alert, animated: true)
            return
        }
        configureSubView()
        
    }

    @IBAction func returnToProfile(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)

        let account = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        account.modalPresentationStyle = .fullScreen
        account.selectedIndex = 1
        present(account, animated: true, completion: nil)

    }
    func addCurrentOrderToSubViews(){
                mainView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 800)

        for i in 0...(OrdersViewController.boughtItems!.count-1){// change to cart items
            mainView!.addSubview(OrdersViewController.currentOrderArray[i])
            mainView!.translatesAutoresizingMaskIntoConstraints = false//
            mainView!.subviews[i+2].frame = CGRect(x: 20, y: (50 + 150 * (i)), width: Int(UIScreen.main.bounds.width) - 40, height: 130)
            mainView!.subviews[i+2].backgroundColor = UIColor(red: 240/255, green: 147/255, blue: CGFloat(150 * abs(sin((Double(i) / 4 * Double.pi))))/255, alpha: 0.80)

        }

        
    }
}
