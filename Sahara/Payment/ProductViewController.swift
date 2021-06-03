//
//  ProductViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/31/21.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var productLB: UILabel!
    @IBOutlet weak var productIMG: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadProduct()
    }
    
    func loadProduct() {
        
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
