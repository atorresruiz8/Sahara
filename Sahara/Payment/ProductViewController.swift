//
//  ProductViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/31/21.
//

import UIKit

class ProductViewController: UIViewController, UITextViewDelegate {
    var ud = UserDefaults.standard
    var product : Product?
    var user : User?
    
    @IBOutlet weak var reviewView: UITextView!
    @IBOutlet weak var priceLB: UILabel!
    @IBOutlet weak var productLB: UILabel!
    @IBOutlet weak var productIMG: UIImageView!
    @IBOutlet weak var submitReviewBut: CustomButton!
    @IBOutlet weak var productRating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadProduct()
        
        reviewView.delegate = self
        reviewView.text = "Please leave your review..."
        reviewView.textColor = UIColor.lightGray
        
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            reviewView.isHidden = true
            submitReviewBut.isHidden = true
            productRating.isHidden = true
        }
        
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
    }
    
    func textViewDidBeginEditing(_ textView : UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView : UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please leave your review..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func loadProduct() {
        product = DBHelper.inst.fetchProduct(id: ud.string(forKey: "currProd")!)
        productLB.text = product!.name
        productIMG.image = UIImage(named: product!.image!)
        priceLB.text = String(format: "$%.2f", (product!.price * product!.salePercentage))
        ud.setValue(product!.id!, forKey: "lastProd")
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let alert = UIAlertController(title: "No Cart Found.", message: "Guests do not have a cart. Please make a full account to access your cart.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            DBHelper.inst.addToCart(prodID: product!.id!, uName: ud.string(forKey: "currUser")!)
        }
    }
    
    @IBAction func addToWishlist(_ sender: Any) {
        DBHelper.inst.addToWishlist(prodID: product!.id!, uName: ud.string(forKey: "currUser")!)
    }
    
    
    @IBAction func keepShopping(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let prof = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        prof.selectedIndex = 0
        prof.modalPresentationStyle = .fullScreen
        present(prof, animated: true, completion: nil)
    }
    
    
    @IBAction func submitFeedback(_ sender: Any) {
        productRating.settings.fillMode = .full
        DBHelper.inst.addReview(prod: product!, usr: user!, review: reviewView.text!, rating: productRating.rating)
        reviewView.text = ""
    }
    
    
    @IBAction func showAllReviews(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let rev = sb.instantiateViewController(withIdentifier: "Review") as! ReviewProductViewController
        rev.modalPresentationStyle = .fullScreen
        present(rev, animated: true, completion: nil)
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
