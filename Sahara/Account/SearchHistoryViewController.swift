//
//  SearchHistoryViewController.swift
//  Sahara
//
//  Created by admin on 5/26/21.
//

import UIKit

class SearchHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let ud = UserDefaults.standard
    var user : User?
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(user!.searchHistory == nil){
            return 0
        }
        return user!.searchHistory!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchHistoryTableViewCell
        myCell.search.text  = user!.searchHistory![indexPath.row]
        myCell.search.sizeToFit()
        myCell.search.numberOfLines = 0
        myCell.backgroundColor = UIColor(red: 240/255, green: 147/255, blue: CGFloat(150 * abs(sin((Double(indexPath.row) / 4 * Double.pi))))/255, alpha: 0.80)
     
        return myCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        if(user?.searchHistory == nil){
            self.tableView.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clearHistory(_ sender: Any) {
        DBHelper.inst.clearSearchHist(user: user!)
        self.tableView.reloadData()
    }
    

    @IBAction func returnToProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // override viewDidAppear if any data needs to change and update because above line doesn't call viewDidLoad in view controller below
    }
}
