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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(user!.wishlist == nil){
            return 0
        }
        return user!.wishlist!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WishListTableViewCell
        cell.itemName.text  = user!.wishlist![indexPath.row].name
        cell.itemPrice.text = String(user!.wishlist![indexPath.row].price)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        if(user?.wishlist == nil){
            self.tableView.isHidden = true
        }

        
    }
    
    
    

   

}
