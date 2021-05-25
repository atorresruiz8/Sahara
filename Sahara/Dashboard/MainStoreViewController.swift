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
       // roundedViews()
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
