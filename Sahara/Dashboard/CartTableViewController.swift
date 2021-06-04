////
////  CartTableViewController.swift
////  Sahara
////
////  Created by Antonio Torres-Ruiz on 5/24/21.
////
//
//import UIKit
//class CartTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    let ud = UserDefaults.standard
//    var user : User?
//    var prod : Product?
//    @IBOutlet weak var headerView: UIView!
//    @IBOutlet weak var bodyView: UIView!
//    @IBOutlet weak var deliveryAddress: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
//
//        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
//            deliveryAddress.isHidden = true
//        } else {
//            if (user!.address != nil) {
//                deliveryAddress.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
//            } else {
//                deliveryAddress.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
//            }
//        }
//
//        if (user?.cart == nil) {
//            tableView.isHidden = true
//        }
//
//        tableView.rowHeight = 128
//    }
//
//    // MARK: - Table view data source
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
//        if (user!.cart!.count == 0) {
//            return 0
//        }
//
//        return user!.cart!.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath) as! CartTableViewCell
//
//        // Configure the cell...
//        prod = DBHelper.inst.fetchProduct(id: user!.cart![indexPath.row])
//        cell.productName.text = prod!.name!
//        cell.productPrice.text = String(format: "$%.2f", prod!.price * prod!.salePercentage)
//        cell.productImg.image = UIImage(named: prod!.image!)
//        return cell
//    }
//
//    @IBAction func purchase(_ sender: Any) {
//
//    }
//
//    @IBAction func deliveryAddress(_ sender: Any) {
//        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
//        let addr = sb.instantiateViewController(withIdentifier: "Addr") as! AddressUpdateViewController
//        addr.modalPresentationStyle = .fullScreen
//        present(addr, animated: true, completion: nil)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
//            deliveryAddress.isHidden = true
//        } else {
//            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
//
//            if (user!.address != nil) {
//                deliveryAddress.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
//            } else {
//                deliveryAddress.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
//            }
//        }
//    }
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
