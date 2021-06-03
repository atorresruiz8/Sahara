//
//  SearchResultsTableViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/30/21.
//

import UIKit

/* If search results produce no results, display “No search results could be found”
 
 Implement searching by checking for specific tags based on the products
 
 Also implement a check for parsing the user input string to see if it “contains” specific keywords that correspond to product names
 */

class SearchResultsTableViewController: UITableViewController {
    
    // Using the static variable "search" from Main Store VC to parse the search text field from said VC
   let search = MainStoreViewController.search
    var ud = UserDefaults.standard
    var prodArr : [Product] = []
    var oneSearch : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = 124
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (search.contains("#tech")) {
            return DBHelper.inst.electronics.count
        } else if (search.contains("#clothing")) {
            return DBHelper.inst.clothing.count
        } else if (search.contains("#decoration")) {
            return DBHelper.inst.decorations.count
        } else if (search.contains("#cooking")) {
            return DBHelper.inst.cooking.count
        } else if (search.contains("#outdoor")) {
            return DBHelper.inst.outdoors.count
        } else if (!search.hasPrefix("#")) {
            oneSearch = DBHelper.inst.fetchProduct(name: search)!
            
            if (oneSearch.count > 0) {
                return oneSearch.count
            } else {
                tableView.isHidden = true
                let alert = UIAlertController(title: "Search does not exist.", message: "We could not find a product similar to your search. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: {_ in
                    self.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true)
                return 0
            }
        } else {
            print("There was an error with parsing the arrays.")
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search", for: indexPath) as! SearchResultsTableViewCell

        // Configure the cell...
        if (search == "") { // empty search
            cell.productLB.text = "You did not search for anything. Please try again."
        } else if (search.hasPrefix("#")) {
            if (search.contains("#tech")) {
                prodArr.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.electronics[indexPath.row])!)
                cell.productLB.text = prodArr[indexPath.row].name
            } else if (search.contains("#clothing")) {
                prodArr.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.clothing[indexPath.row])!)
                cell.productLB.text = prodArr[indexPath.row].name
            } else if (search.contains("#decoration")) {
                prodArr.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.decorations[indexPath.row])!)
                cell.productLB.text = prodArr[indexPath.row].name
            } else if (search.contains("#outdoor")) {
                prodArr.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.outdoors[indexPath.row])!)
                cell.productLB.text = prodArr[indexPath.row].name
            } else if (search.contains("#cooking")) {
                prodArr.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.cooking[indexPath.row])!)
                cell.productLB.text = prodArr[indexPath.row].name
            } else {
                cell.productLB.text = "Could not find anything. Please try a new search."
            }
            
            let sale = prodArr[indexPath.row].salePercentage * prodArr[indexPath.row].price
            cell.priceLB.text = String(format: "$%.2f", sale)
            cell.productIMG.image = UIImage(named: prodArr[indexPath.row].image!)
            cell.productIMG.contentMode = .scaleAspectFit
        } else { // check if search contains a product name as a string
            cell.productLB.text = oneSearch[indexPath.row].name
            let sale = oneSearch[indexPath.row].salePercentage * oneSearch[indexPath.row].price
            cell.priceLB.text = String(format: "$%.2f", sale)
            cell.productIMG.image = UIImage(named: oneSearch[indexPath.row].image!)
            cell.productIMG.contentMode = .scaleAspectFit
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (search != "") {
            ud.setValue(indexPath.row, forKey: "prodID")
            let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
            let prod = sb.instantiateViewController(withIdentifier: "Product") as! ProductViewController
            //prod.modalPresentationStyle = .fullScreen
            present(prod, animated: true, completion: nil)
        
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
