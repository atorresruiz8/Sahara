//
//  ForgotPasswordViewController.swift
//  Sahara
//
//  Created by Peter G on 5/26/21.
//

import UIKit
import CryptoKit
class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var uName: UITextField!
    @IBOutlet weak var newPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func savenew(_ sender: Any) {
        if(newPass.text!.count < 6){
            let alMess = "please make sure that your password has at least 6 characters."
            let alert = UIAlertController(title: "Password too short", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        let inputString = newPass.text!  + "423"
        
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        let user = DBHelper.inst.fetchUser(query: uName.text!)
        DBHelper.inst.updateInfo(user: user!, object: ["pass" : String(describing : hashed)])
        
    }
    

}
