//
//  ProductViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/31/21.
//

import UIKit

class ProductViewController: UIViewController {
    var ud = UserDefaults.standard
    var product : Product?
    @IBOutlet weak var reviewView: UITextView!
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var productLB: UILabel!
    @IBOutlet weak var productIMG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadProduct()
        
        reviewView.clearsOnInsertion = true 
    }
    
    func loadProduct() {
        product = DBHelper.inst.fetchProduct(id: ud.string(forKey: "currProd")!)
        productLB.text = product!.name
        productIMG.image = UIImage(named: product!.image!)
        priceLB.text = String(format: "$%.2f", (product!.price * product!.salePercentage))
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
    }
    
    @IBAction func addToWishlist(_ sender: Any) {
        
    }
    
    @IBAction func checkOut(_ sender: Any) {
        
    }
    
    
    @IBAction func keepShopping(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prof = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        prof.selectedIndex = 0
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
