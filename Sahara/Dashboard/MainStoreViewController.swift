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
