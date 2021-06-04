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
        if ud.bool(forKey: "rem"){
            uName.text = ud.string(forKey: "uName")
            uPass.text = ud.string(forKey: "uPass")
            remState.isOn = true
        }
        else{
            remState.isOn = false
        }
        // Do any additional setup after loading the view.
        // initializes the arrays with the products filtered by tags
        DBHelper.inst.arrayMaker()
        DBHelper.inst.checkProducts()
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
                print("here")
                ud.setValue(uName.text!, forKey: "currUser")
                if(remState.isOn){
                    ud.setValue(uName.text!, forKey: "uName")
                    ud.setValue(uPass.text!, forKey: "uPass")
                    ud.setValue(true, forKey: "rem")
                }
                

                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dash = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
                dash.modalPresentationStyle = .fullScreen
                present(dash, animated: true, completion: nil)
            }
        }
        else{
            if(DBHelper.inst.validatePhonePass(uName: uName.text!, uPass: String(describing: hashed))){
                ud.setValue(uName.text!, forKey: "currUser")
                if(remState.isOn){
                    ud.setValue(uName.text!, forKey: "uName")
                    ud.setValue(uPass.text!, forKey: "uPass")
                    ud.setValue(true, forKey: "rem")
                }
                
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let dash = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
                dash.modalPresentationStyle = .fullScreen
                present(dash, animated: true, completion: nil)
            }
        }
    }
  
    @IBAction func browseLogin(_ sender: Any) {
        
        // saves the current temp user ID so they can log into the same temp user multiple times
        if (ud.string(forKey: "currUser") != nil && ud.string(forKey: "currUser")!.hasPrefix("_")) {
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let dash = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
            // display the segue in full screen
            dash.modalPresentationStyle = .fullScreen
            // present the view controller
            present(dash, animated: true, completion: nil)
            return
        }
        
        let ret = DBHelper.inst.addTempUser()
        if(ret == "error"){
            let alert = UIAlertController(title: "Error making temp account", message: "please close and reopen the app to try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "O.K.", style: .cancel, handler: nil))
            present(alert, animated: true)
                
        }
        else{
            ud.setValue(ret, forKey: "currUser")
        }
        //login
        
        // Instantiate the dashboard screen from the "Main" storyboard to allow the user to visit the store

        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dash = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        // display the segue in full screen
        dash.modalPresentationStyle = .fullScreen
        // present the view controller
        present(dash, animated: true, completion: nil)
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
