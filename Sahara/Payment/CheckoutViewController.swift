//
//  CheckoutViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/31/21.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var shippingAddress: UILabel!
    @IBOutlet weak var paycCardbutt: CustomButton!
    @IBOutlet weak var paynetBankButt: CustomButton!
    var ud = UserDefaults.standard
    var user : User?
    var totalPrice = 0.00
    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var cCardInfo: UILabel!
    @IBOutlet weak var netBankInfo: UILabel!
    @IBOutlet weak var deliveryDate: UILabel!
    @IBOutlet weak var shippingHandling: UILabel!
    @IBOutlet weak var costOfItems: UILabel!
    @IBOutlet weak var clientAddr: UILabel!
    @IBOutlet weak var clientName: UILabel!
    override func viewDidAppear(_ animated: Bool) {
        user = DBHelper.inst.fetchUser(query:  ud.string(forKey: "currUser")!)
        if (user!.address != nil) {
        shippingAddress.text =  "Shipping to : " + user!.address!.street + ", " + user!.address!.city + ", " + user!.address!.state
        }
        else {
            shippingAddress.text =  "Shipping to : " + "N/A" + ", " + "N/A" + ", " + "N/A"
            
        }
        totalPrice = CartViewController.cartPrice
        costOfItems.text =
            String(format: "$%.2f", CartViewController.cartPrice)
        if(CartViewController.cartPrice < 200.00){
            shippingHandling.text =
                String(format: "$%.2f", 10.00)
            totalPrice += 10.00
        }
        else{
            shippingHandling.text =
                String(format: "$%.2f", 0.00)
            totalPrice += 0.00
        }
        orderTotal.text = String(format: "$%.2f", totalPrice)
        clientName.text = user!.name!
        if (user!.address != nil) {
        clientAddr.text =  "Shipping to : " + user!.address!.street + ", " + user!.address!.city + ", " + user!.address!.state
        }
        else {
            clientAddr.text =  "Please Click the arrow to add your Address"
            
        }
        if(user!.creditCard != nil){
            cCardInfo.text = "Credit Card ending in " + user!.creditCard!.number.suffix(4)
            paycCardbutt.isHidden = false
        }
        else{
            cCardInfo.isHidden = true
            paycCardbutt.isHidden = true
            

        }
        if(user!.netBanking != nil){
            netBankInfo.text = "Net Banking ending in " + user!.netBanking!.suffix(4)
            paynetBankButt.isHidden = false
        }
        else{
            netBankInfo.isHidden = true
            paynetBankButt.isHidden = true
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = DBHelper.inst.fetchUser(query:  ud.string(forKey: "currUser")!)
        if (user!.address != nil) {
        shippingAddress.text =  "Shipping to : " + user!.address!.street + ", " + user!.address!.city + ", " + user!.address!.state
        }
        else {
            shippingAddress.text =  "Shipping to : " + "N/A" + ", " + "N/A" + ", " + "N/A"
            
        }
        totalPrice = CartViewController.cartPrice
        costOfItems.text =
            String(format: "$%.2f", CartViewController.cartPrice)
        if(CartViewController.cartPrice < 200.00){
            shippingHandling.text =
                String(format: "$%.2f", 10.00)
            totalPrice += 10.00
        }
        else{
            shippingHandling.text =
                String(format: "$%.2f", 0.00)
            totalPrice += 0.00
        }
        orderTotal.text = String(format: "$%.2f", totalPrice)
        clientName.text = user!.name!
        if (user!.address != nil) {
        clientAddr.text =  "Shipping to : " + user!.address!.street + ", " + user!.address!.city + ", " + user!.address!.state
        }
        else {
            clientAddr.text =  "Please Click the arrow to add your Address"
            
        }
        let currDate = Date()
                var dateComp = DateComponents()
                dateComp.day = 7
                let futureDate = Calendar.current.date(byAdding: dateComp, to: currDate)
        let df = DateFormatter()
        df.dateFormat = "MM/dd/YY"
        deliveryDate.text = "Delivery Day is : " + df.string(from: futureDate!)
    }
    

    @IBAction func returnToMain(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        main.modalPresentationStyle = .fullScreen
        main.selectedIndex = 0
        present(main, animated: true, completion: nil)
    }
    @IBAction func goToShipping(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "Addr") as! AddressUpdateViewController
        main.modalPresentationStyle = .fullScreen
        present(main, animated: true, completion: nil)

        
    }

    @IBAction func payDelivery(_ sender: Any) {
        for item in user!.cart!{
            DBHelper.inst.addBoughtProduct(uName: ud.string(forKey: "currUser")!, pID: item, paid: false)
            
        }
        DBHelper.inst.clearCart(uName: ud.string(forKey: "currUser")!)
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        main.modalPresentationStyle = .fullScreen
        main.selectedIndex = 0
        present(main, animated: true, completion: nil)
    }
    @IBAction func paycCard(_ sender: Any) {
        //actual method to withdraw funds would go here.
        for item in user!.cart!{
            DBHelper.inst.addBoughtProduct(uName: ud.string(forKey: "currUser")!, pID: item, paid: true)
        }
        DBHelper.inst.subUserBalance(uName: ud.string(forKey: "currUser")!, amount: totalPrice)
        DBHelper.inst.clearCart(uName: ud.string(forKey: "currUser")!)
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        main.modalPresentationStyle = .fullScreen
        main.selectedIndex = 0
        present(main, animated: true, completion: nil)
       
    }
    
    @IBAction func payNetBanking(_ sender: Any) {
        //actual method to withdraw funds would go here.
        for item in user!.cart!{
            DBHelper.inst.addBoughtProduct(uName: ud.string(forKey: "currUser")!, pID: item, paid: true)
        }
        DBHelper.inst.subUserBalance(uName: ud.string(forKey: "currUser")!, amount: totalPrice)
        DBHelper.inst.clearCart(uName: ud.string(forKey: "currUser")!)
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        main.modalPresentationStyle = .fullScreen
        main.selectedIndex = 0
        present(main, animated: true, completion: nil)
       
    }
    @IBAction func paymentOptions(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let main = sb.instantiateViewController(withIdentifier: "meth") as! PaymentMakerViewController
        main.modalPresentationStyle = .fullScreen
        present(main, animated: true, completion: nil)
        
    }
}
