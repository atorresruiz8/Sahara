//
//  ProfileViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var walletBalance: UILabel!
    @IBOutlet weak var reloadBut: UIButton!
    @IBOutlet weak var refundBut: UIButton!
    @IBOutlet weak var subBut: UIButton!
    @IBOutlet weak var histBut: UIButton!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var addToCartBut: UIButton!
    @IBOutlet weak var showOrdersBut: UIButton!
    @IBOutlet weak var wishlistBut: UIButton!
    @IBOutlet weak var buyAgainBut: UIButton!
    @IBOutlet weak var helloMessage: UILabel!
    @IBOutlet weak var accountBut: UIButton!
    @IBOutlet weak var ordersBut: UIButton!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bodyViewGradient()
        viewCurves()
        buttonCurvesAndBorders()
    }
    
    func buttonCurvesAndBorders() {
        reloadBut.layer.borderWidth = 2
        reloadBut.layer.cornerRadius = 15.0
        reloadBut.layer.cornerCurve = .continuous
        
        refundBut.layer.borderWidth = 2
        refundBut.layer.cornerRadius = 15.0
        refundBut.layer.cornerCurve = .continuous
        
        subBut.layer.borderWidth = 2
        subBut.layer.cornerRadius = 15.0
        subBut.layer.cornerCurve = .continuous
        
        ordersBut.layer.borderWidth = 2
        ordersBut.layer.cornerRadius = 15.0
        ordersBut.layer.cornerCurve = .continuous
        
        accountBut.layer.borderWidth = 2
        accountBut.layer.cornerRadius = 15.0
        accountBut.layer.cornerCurve = .continuous
        
        buyAgainBut.layer.borderWidth = 2
        buyAgainBut.layer.cornerRadius = 15.0
        buyAgainBut.layer.cornerCurve = .continuous
        
        wishlistBut.layer.borderWidth = 2
        wishlistBut.layer.cornerRadius = 15.0
        wishlistBut.layer.cornerCurve = .continuous
        
        showOrdersBut.layer.borderWidth = 2
        showOrdersBut.layer.cornerRadius = 15.0
        showOrdersBut.layer.cornerCurve = .continuous
        
        addToCartBut.layer.borderWidth = 2
        addToCartBut.layer.cornerRadius = 15.0
        addToCartBut.layer.cornerCurve = .continuous
        
        histBut.layer.borderWidth = 2
        histBut.layer.cornerRadius = 15.0
        histBut.layer.cornerCurve = .continuous
    }

    func viewCurves() {
        userView.layer.cornerRadius = 15.0
        userView.layer.masksToBounds = true
        
        accountView.layer.cornerRadius = 15.0
        accountView.layer.masksToBounds = true
        
        walletView.layer.cornerRadius = 15.0
        walletView.layer.masksToBounds = true
    }
    
    func bodyViewGradient() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = bodyView.bounds
        
        // Set an array of CGColors to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1).cgColor, UIColor(red: 150/255, green: 180/255, blue: 180/255, alpha: 0.80).cgColor]
        
        // Rasterize this layer to improve perfromance
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the background
        bodyView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Diagonal: top left to bottom corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // top left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // bottom right
    }
    
    
    @IBAction func showOrders(_ sender: Any) {
    }
    
    
    @IBAction func buyAgain(_ sender: Any) {
    }
    
    @IBAction func showAccount(_ sender: Any) {
    }
    
    
    @IBAction func showWishlist(_ sender: Any) {
    }
    
    @IBAction func showAllOrders(_ sender: Any) {
    }
    
    @IBAction func addToCart(_ sender: Any) {
    }
    
    @IBAction func displayOrders(_ sender: Any) {
    }
    
    
    @IBAction func browsingHistory(_ sender: Any) {
    }
    
    @IBAction func subscribeServices(_ sender: Any) {
    }
    
    @IBAction func refundOrders(_ sender: Any) {
    }
    
    @IBAction func addToWalletBalance(_ sender: Any) {
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
