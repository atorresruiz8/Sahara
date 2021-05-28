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
        return myCell
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
    }
    

    @IBAction func returnToProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        // override viewDidAppear if any data needs to change and update because above line doesn't call viewDidLoad in view controller below
    }
}
