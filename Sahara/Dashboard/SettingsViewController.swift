//
//  SettingsViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var cookingBut: UIButton!
    @IBOutlet weak var furnitureBut: UIButton!
    @IBOutlet weak var outdoorsBut: UIButton!
    @IBOutlet weak var clothingBut: UIButton!
    @IBOutlet weak var elecBut: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerViewGradient()
        bodyViewGradient()
        roundedViews()
        buttonEdits()
    }
    
    func buttonEdits() {
        elecBut.layer.borderWidth = 2
        elecBut.layer.cornerRadius = 15.0
        elecBut.layer.cornerCurve = .continuous
        
        clothingBut.layer.borderWidth = 2
        clothingBut.layer.cornerRadius = 15.0
        clothingBut.layer.cornerCurve = .continuous
        
        outdoorsBut.layer.borderWidth = 2
        outdoorsBut.layer.cornerRadius = 15.0
        outdoorsBut.layer.cornerCurve = .continuous
        
        furnitureBut.layer.borderWidth = 2
        furnitureBut.layer.cornerRadius = 15.0
        furnitureBut.layer.cornerCurve = .continuous
        
        cookingBut.layer.borderWidth = 2
        cookingBut.layer.cornerRadius = 15.0
        cookingBut.layer.cornerCurve = .continuous
    }
    
    func roundedViews() {
        departmentView.layer.cornerRadius = 15.0
        departmentView.layer.masksToBounds = true
        accountView.layer.cornerRadius = 15.0
        accountView.layer.masksToBounds = true
    }
    
    func headerViewGradient() {
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the size of the layer to be equal to the size of the display
        gradientLayer.frame = headerView.bounds
        
        // Set an array of CGColors to create the gradient
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1).cgColor, UIColor(red: 150/255, green: 180/255, blue: 180/255, alpha: 0.80).cgColor]
        
        // Rasterize this layer to improve perfromance
        gradientLayer.shouldRasterize = true
        
        // Apply the gradient to the background
        headerView.layer.insertSublayer(gradientLayer, at: 0)
        
        // Diagonal: top left to bottom corner
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // top left
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // bottom right
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
    
    @IBAction func showWishlist(_ sender: Any) {
    }
    
    @IBAction func showAccount(_ sender: Any) {
    }
    
    @IBAction func showBrowsingHistory(_ sender: Any) {
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
    
    @IBAction func textToSpeechSearch(_ sender: Any) {
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
