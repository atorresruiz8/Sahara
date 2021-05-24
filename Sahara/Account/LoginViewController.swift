//
//  LoginViewController.swift
//  Sahara
//
//  Created by Peter G on 5/24/21.
//

import UIKit
import CryptoKit
class LoginViewController: UIViewController {
    let ud = UserDefaults.standard
    @IBOutlet weak var remState: UISwitch!
    
    @IBOutlet weak var uName: UITextField! //username text input
    @IBOutlet weak var uPass: UITextField! //password text input
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //button for logging in
    @IBAction func login(_ sender: Any) {
        let inputString = uPass.text!  + "423"
        
        let inputData = Data(inputString.utf8)
        let hashed = SHA256.hash(data: inputData)
        if(uName.text == ""){
            let alMess = "Please enter login credintials"
            let alert = UIAlertController(title: "Error text field blank", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if(uName.text!.contains("@")){
            if(DBHelper.inst.validateEmailPass(uName: uName.text!, uPass: String(describing: hashed))){
                //login
            }
        }
        else{
            if(DBHelper.inst.validatePhonePass(uName: uName.text!, uPass: String(describing: hashed))){
                //login
            }
        }
    }
  
    @IBAction func browseLogin(_ sender: Any) {
        DBHelper.inst.addTempUser()
        //login
    }
    @IBAction func remSwitched(_ sender: Any) {
        if(remState.isOn){
            
            ud.setValue(uName.text, forKey: "uName")
            ud.setValue(true, forKey: "rem")
            ud.setValue(uPass.text, forKey: "uPass")
            
        }
        else{
            ud.removeObject(forKey: "uName")
            ud.removeObject(forKey: "uPass")
            ud.setValue(false, forKey: "rem")
        }
    }
    
}
