//
//  MainStoreViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit

class MainStoreViewController: UIViewController {

    @IBOutlet weak var dailyDealView: UIView!
    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var inspiredView: UIView!
    @IBOutlet weak var exploreItemView: UIView!
    @IBOutlet weak var deliverToUser: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var searchQuery: UITextField!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       headerViewGradient()
        bodyViewGradient()
        roundedViews()
    }
    
    func roundedViews() {
        dailyDealView.layer.cornerRadius = 15.0
        dailyDealView.layer.masksToBounds = true
        recentView.layer.cornerRadius = 15.0
        recentView.layer.masksToBounds = true
        inspiredView.layer.cornerRadius = 15.0
        inspiredView.layer.masksToBounds = true
        exploreItemView.layer.cornerRadius = 15.0
        exploreItemView.layer.masksToBounds = true
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
    
    @IBAction func delivery(_ sender: Any) {
        
    }
    
    @IBAction func textToSpeech(_ sender: Any) {
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
