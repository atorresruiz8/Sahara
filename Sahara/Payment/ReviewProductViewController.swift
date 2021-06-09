//
//  ReviewProductViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class ReviewProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ud = UserDefaults.standard
    var prod : Product?
    var rev : [Review] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productName: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (prod!.review!.count == 0) {
            tableView.isHidden = true
            // put an alert to say no reviews exist
            let alert = UIAlertController(title: "No Reviews Found.", message: "No one has reviewed this product before. Be the first to let people know how the product is!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
            return 0
        } else {
            return prod!.review!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Review", for: indexPath) as! ReviewTableViewCell
        let r = rev[indexPath.row]
        if(r.comment == "Please leave your review..." ){
            r.comment = " "
        }
        cell.productReview.text = r.comment
        cell.username.text = r.user!.name!
        cell.userRating.rating = r.rating
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = 128
        prod = DBHelper.inst.fetchProduct(id: ud.string(forKey: "currProd")!)
        productName.text = prod!.name!
        rev = prod!.review!.allObjects as! [Review]
    }
    
    @IBAction func returnToProduct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
