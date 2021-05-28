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
        } else {
            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            
            helloMessage.text = "\(String(describing: user!.name!))"
        }
    }
    
    @IBAction func showCurrentOrders(_ sender: Any) {
    }
    
    
    @IBAction func showWishlist(_ sender: Any) {
    }
    
    
    @IBAction func showAllOrders(_ sender: Any) {
    }
    
    @IBAction func showCart(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    
    @IBAction func showBrowsingHistory(_ sender: Any) {
    }
    
    
    
    @IBAction func showSubscriptionServices(_ sender: Any) {
    }
    
    
    @IBAction func showAccount(_ sender: Any) {
    }
    
    
    @IBAction func showRefunds(_ sender: Any) {
    }
    
    @IBAction func addToWalletBalance(_ sender: Any) {
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
