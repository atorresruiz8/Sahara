//
//  currentOrdersViewController.swift
//  Sahara
//
//  Created by Justin Horner on 6/4/21.
//

import UIKit

class currentOrdersViewController: UIViewController {
    var currentOrderArray : [currentOrderItem] = []
    func testCurrentOrders(){
        currentOrderArray = []
        currentOrderArray.append(currentOrderItem(cOrderName: "Doggo", cOrderPrice: "55.11", deliver: true))
        currentOrderArray.append(currentOrderItem(cOrderName: "Gato", cOrderPrice: "111.11", deliver: true))
        
    }
    func addCurrentOrdersToSubView(){
        let selectPayment = UILabel()
        selectPayment.text = "Select a Payment Method"
        selectPayment.frame = CGRect(x: 50, y: 50, width: Int(UIScreen.main.bounds.width) - 100, height: 100)
        view.addSubview(selectPayment)
        for i in 0...viewPaymentItemArray.count-1{
            viewPaymentItemArray[i].backgroundColor = .red
            view.addSubview(viewPaymentItemArray[i])
            view.subviews[i+1].frame = CGRect(x:50, y:(150 + 100*(i)), width: Int(UIScreen.main.bounds.width) - 100, height: 75)
        }
        let addPayment = UIButton()
        addPayment.setTitle("Add a Payment Method", for: .normal)
        addPayment.backgroundColor = .black
        print(addPayment.frame)
        view.addSubview(addPayment)
 
        view.subviews[viewPaymentItemArray.count+1].frame = CGRect(x:50, y:(150 + 100*(viewPaymentItemArray.count)), width: Int(UIScreen.main.bounds.width) - 100, height: 50)
        
        let continueButton = UIButton()
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = .black
        view.addSubview(continueButton)
        view.subviews[viewPaymentItemArray.count+2].frame = CGRect(x:50, y:(150 + 100*(viewPaymentItemArray.count+1)), width: Int(UIScreen.main.bounds.width) - 100, height: 50)
    }
    override func viewDidLoad() {
        testCurrentOrders()
        addCurrentOrdersToSubView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    class currentOrderItem {
        var currentOrderName: String
        var currentOrderPrice: String
        var delivered: Bool
        init(cOrderName: String, cOrderPrice: String, deliver: Bool) {
            currentOrderName = cOrderName
            currentOrderPrice = cOrderPrice
            delivered = deliver
        }
    }
    class currentOrderView : UIButton {
        var currentOrderViewName: String
        var currentOrderViewPrice: String
        init(currentOrder: currentOrderItem){
            currentOrderViewName = currentOrder.currentOrderName
            currentOrderViewPrice = currentOrder.currentOrderPrice
            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let name = UILabel()
            name.text = currentOrderViewName
            name.frame = CGRect(x:20, y: 30, width: 150, height: 15)
            self.addSubview(name)
            let price = UILabel()
            price.text = currentOrderViewPrice
            price.frame = CGRect(x:20, y:50, width: 150, height: 15)
            self.addSubview(price)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
