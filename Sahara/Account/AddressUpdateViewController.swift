//
//  AddressUpdateViewController.swift
//  Sahara
//
//  Created by Peter G on 5/26/21.
//

import UIKit

class AddressUpdateViewController: UIViewController {
    let ud = UserDefaults.standard
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func update(_ sender: Any) {
        var address : Address
        if(street.text!.count > 0 && city.text!.count > 0 && state.text!.count == 2 && country.text!.count > 0 && zipcode.text!.count > 0) {
            address = Address(street : street.text!, city : city.text!, state : state.text!, country : country.text!, zipcode : zipcode.text!)
            DBHelper.inst.updateAddress(user : ud.string(forKey: "currUser")!, add: address)
        }
        
        
    }
    

}
