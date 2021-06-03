//
//  WishListViewController.swift
//  Sahara
//
//  Created by Peter G on 5/26/21.
//

import UIKit

class WishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ud = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    var user : User?
    var prod : Product?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        
        if(user!.wishlist!.count == 0) {
            return 0
        }
        
        return user!.wishlist!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTableViewCell
        prod = DBHelper.inst.fetchProduct(id: user!.wishlist![indexPath.row])
        cell.itemName.text = prod!.name!
        cell.itemPrice.text = String(format: "$%.2f", prod!.price * prod!.salePercentage)
        cell.itemImg.image = UIImage(named: prod!.image!)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        if(user?.wishlist == nil){
            self.tableView.isHidden = true
        }

        tableView.rowHeight = 128
    }
    
    
    
    @IBAction func returnToProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // override viewDidAppear if any data needs to change and update because above line doesn't call viewDidLoad in view controller below
    }
    
   

}
