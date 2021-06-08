//
//  paymentMethodViewController.swift
//  Sahara
//
//  Created by Justin Horner on 6/3/21.
//

import UIKit

class paymentMethodViewController: UIViewController {
    var viewPaymentItemArray : [viewPaymentItem] = []
    func testPaymentItem(){
        viewPaymentItemArray = []
        let COD = paymentItem()
        COD.paymentItemType = "Cash On Delivery"
        COD.paymentItemName = "ID required"
        COD.paymentItemNumber = ""
        COD.paymentItemDate = ""
        let test1 = paymentItem()
        test1.paymentItemType = "Debit"
        test1.paymentItemName = "Justin Horner"
        test1.paymentItemDate = "12/24"
        test1.paymentItemNumber = "4444"
        let test2 = paymentItem()
        test2.paymentItemType = "Debit"
        test2.paymentItemName = "Phil Mickleson"
        test2.paymentItemDate = "12/22"
        test2.paymentItemNumber = "7277"
        viewPaymentItemArray.append(viewPaymentItem(paymentItem: COD))
        viewPaymentItemArray.append(viewPaymentItem(paymentItem: test1))
        viewPaymentItemArray.append(viewPaymentItem(paymentItem: test2))
        
    }
    func addViewPaymentItemsToSubView(){
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
        testPaymentItem()
        addViewPaymentItemsToSubView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    class paymentItem {
        var paymentItemType: String = ""
        var paymentItemName: String = ""
        var paymentItemNumber: String = ""
        var paymentItemDate: String = ""
    }
    class viewPaymentItem : UIButton {
        var viewPaymentItemType: String
        var viewPaymentItemName: String
        var viewPaymentItemNumber: String
        var viewPaymentItemDate: String
        init(paymentItem: paymentItem){
            viewPaymentItemType = paymentItem.paymentItemType
            viewPaymentItemName = paymentItem.paymentItemName
            viewPaymentItemNumber = paymentItem.paymentItemNumber
            viewPaymentItemDate = paymentItem.paymentItemDate
            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let circle = UIImageView(image: UIImage(systemName: "circle"))
            circle.frame = CGRect(x:0, y: 50, width: 10, height: 10)
            self.addSubview(circle)
            let type = UILabel()
            type.text = viewPaymentItemType
            type.frame = CGRect(x:20, y:10, width: 150, height: 15)
            self.addSubview(type)
            let name = UILabel()
            name.text = viewPaymentItemName
            name.frame = CGRect(x:20, y: 30, width: 150, height: 15)
            self.addSubview(name)
            let date = UILabel()
            date.text = viewPaymentItemDate
            date.frame = CGRect(x:20, y:50, width: 150, height: 15)
            self.addSubview(date)
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
