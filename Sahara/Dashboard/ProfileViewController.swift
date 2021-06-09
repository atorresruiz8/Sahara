//
//  ProfileViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class ProfileViewController: UIViewController {
    let ud = UserDefaults.standard
    var user : User?
    @IBOutlet weak var walletBalance: UILabel!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var helloMessage: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            helloMessage.text = "Guest"
            walletBalance.text = "Wallet Balance: N/A"
        } else {
            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            
            helloMessage.text = "\(String(describing: user!.name!))"
            
            walletBalance.text = "Wallet Balance: $\(user!.balance)"
        }
    }
    
    @IBAction func showCurrentOrders(_ sender: Any) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let alert = UIAlertController(title: "No Orders Found.", message: "Guests cannot order anything. Please make a full account to order products.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            // instantiate current orders screen here
            let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
            let current = sb.instantiateViewController(withIdentifier: "current") as! currentOrdersViewController
            current.modalPresentationStyle = .fullScreen
            present(current, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func showWishlist(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let wish = sb.instantiateViewController(withIdentifier: "Wish") as! WishListViewController
        wish.modalPresentationStyle = .fullScreen
        present(wish, animated: true, completion: nil)
    }
    
    
    @IBAction func showAllOrders(_ sender: Any) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let alert = UIAlertController(title: "No Orders Found.", message: "Guests cannot order anything. Please make a full account to order products.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            // instantiate all orders screen here
            let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
            let order = sb.instantiateViewController(withIdentifier: "Order") as! OrdersViewController
            order.modalPresentationStyle = .fullScreen
            present(order, animated: true, completion: nil)
        }
    }
    
    @IBAction func showCart(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    
    @IBAction func showBrowsingHistory(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let sh = sb.instantiateViewController(withIdentifier: "SearchHistory") as! SearchHistoryViewController
        sh.modalPresentationStyle = .fullScreen
        present(sh, animated: true, completion: nil)
    }
    
    
    
    @IBAction func showRefunds(_ sender: Any) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let alert = UIAlertController(title: "No Orders Found.", message: "Guests cannot order anything. Please make a full account to order products.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
            let refund = sb.instantiateViewController(withIdentifier: "Refund") as! RefundViewController
            refund.modalPresentationStyle = .fullScreen
            present(refund, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func showAccount(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let prof = sb.instantiateViewController(withIdentifier: "ProfileEdit") as! ProfileEditorViewController
        prof.modalPresentationStyle = .fullScreen
        present(prof, animated: true, completion: nil)
    }
    
    
    @IBAction func changeAddressInfo(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let addr = sb.instantiateViewController(withIdentifier: "Addr") as! AddressUpdateViewController
        addr.modalPresentationStyle = .fullScreen
        present(addr, animated: true, completion: nil)
    }
    
    @IBAction func paymentInfo(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let pay = sb.instantiateViewController(withIdentifier: "Payment") as! PaymentViewController
        pay.modalPresentationStyle = .fullScreen
        present(pay, animated: true, completion: nil)
    }
    
    @IBAction func addToWalletBalance(_ sender: Any) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let alert = UIAlertController(title: "No Wallet Found.", message: "Guests do not have a wallet. Please make a full account to access your wallet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wallet = sb.instantiateViewController(withIdentifier: "Wallet") as! WalletViewController
            wallet.modalPresentationStyle = .fullScreen
            present(wallet, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        ud.setValue("", forKey: "currUser")
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
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
