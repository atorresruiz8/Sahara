//
//  WalletViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 6/1/21.
//

import UIKit

class WalletViewController: UIViewController {
    var user: User?
    let ud = UserDefaults.standard
    @IBOutlet weak var custAmt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
    }
    
    @IBAction func displayWalletBalance(_ sender: Any) {
        let alert = UIAlertController(title: "Wallet Balance", message: "Your balance is: $\(user!.balance).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    @IBAction func add10ToBalance(_ sender: Any) {
        DBHelper.inst.updateBalance(amount: 10, query: ud.string(forKey: "currUser")!)
    }
    
    @IBAction func add25ToBalance(_ sender: Any) {
        DBHelper.inst.updateBalance(amount: 25, query: ud.string(forKey: "currUser")!)
    }
    
    @IBAction func add50ToBalance(_ sender: Any) {
        DBHelper.inst.updateBalance(amount: 50, query: ud.string(forKey: "currUser")!)
    }
    
    @IBAction func add100ToBalance(_ sender: Any) {
        DBHelper.inst.updateBalance(amount: 100, query: ud.string(forKey: "currUser")!)
    }
    
    @IBAction func addCustomAmount(_ sender: Any) {
        DBHelper.inst.updateBalance(amount: Double(custAmt.text!)!, query: ud.string(forKey: "currUser")!)
        custAmt.text = ""
    }
    
    
    @IBAction func returnToProfile(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prof = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        prof.selectedIndex = 1
        prof.modalPresentationStyle = .fullScreen
        present(prof, animated: true, completion: nil)
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
