//
//  SettingsViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
class SettingsViewController: UIViewController {

    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showOrders(_ sender: Any) {
    }
    
    @IBAction func buyAgain(_ sender: Any) {
    }
    
    @IBAction func showWishlist(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let wish = sb.instantiateViewController(withIdentifier: "Wish") as! WishListViewController
        wish.modalPresentationStyle = .fullScreen
        present(wish, animated: true, completion: nil)
    }
    
    @IBAction func showAccount(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let prof = sb.instantiateViewController(withIdentifier: "ProfileEdit") as! ProfileEditorViewController
        prof.modalPresentationStyle = .fullScreen
        present(prof, animated: true, completion: nil)
    }
    
    @IBAction func showBrowsingHistory(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let sh = sb.instantiateViewController(withIdentifier: "SearchHistory") as! SearchHistoryViewController
        sh.modalPresentationStyle = .fullScreen
        present(sh, animated: true, completion: nil)
    }
    
    @IBAction func showRefunds(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let refund = sb.instantiateViewController(withIdentifier: "Refund") as! RefundViewController
        refund.modalPresentationStyle = .fullScreen
        present(refund, animated: true, completion: nil)
    }
    
    @IBAction func elecDept(_ sender: Any) {
    }
    
    @IBAction func clothingDept(_ sender: Any) {
    }
    
    @IBAction func outdoorsDept(_ sender: Any) {
    }
    
    @IBAction func cookingDept(_ sender: Any) {
    }
    
    @IBAction func furnitureDept(_ sender: Any) {
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
