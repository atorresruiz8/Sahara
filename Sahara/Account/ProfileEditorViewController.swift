//
//  ProfileEditorViewController.swift
//  Sahara
//
//  Created by admin on 5/25/21.
//

import UIKit

class ProfileEditorViewController: UIViewController {
    let ud = UserDefaults.standard
    var user : User?
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var tempAcctBut: CustomButton!
    
    @IBOutlet weak var userEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        userName.text = user!.name
        userEmail.text = user!.email
        userPhone.text = user!.phoneNumber
        // Do any additional setup after loading the view.
        
        tempAcctBut.isHidden = true
        
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            tempAcctBut.isHidden = false
        }
    }
    

    @IBAction func editname(_ sender: Any) {
        userName.isUserInteractionEnabled = true
    }
    @IBAction func submit(_ sender: Any) {
        var objec = ["" : ""]
        if(userEmail.text != ""){
            if(emailCheck(email: userEmail.text!)){
                objec["email"] = userEmail.text!
            }
            else{
                return
            }
        }
        if(userPhone.text != ""){
            if(checkNumber(num: userPhone.text!)){
                objec["phoneNumber"] = userPhone.text!
            }
            else{
                return
            }
        }
        objec["name"] = userName.text!
        DBHelper.inst.updateInfo(user: user!, object: objec)
        userName.isUserInteractionEnabled = false
        userEmail.isUserInteractionEnabled = false
        userPhone.isUserInteractionEnabled = false
        
        self.dismiss(animated: true, completion: nil)
        // override viewDidAppear if any data needs to change and update because above line doesn't call viewDidLoad in view controller below
    }
    
    @IBAction func editEmail(_ sender: Any) {
        userEmail.isUserInteractionEnabled = true
    }
    
    @IBAction func editPhone(_ sender: Any) {
        userPhone.isUserInteractionEnabled = true
    }
    @IBAction func clearHistory(_ sender: Any) {
        DBHelper.inst.clearHistory(query: user!)
    }
    
    
    
    func emailCheck(email : String) -> Bool{
        let newEm = email.split(separator: "@")
        if(!(newEm.count == 2)){
            let alMess = "not a valid email"
            let alert = UIAlertController(title: "Error Invalid Email", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        if(newEm[0].count == 0 || newEm[1].count == 0){
            let alMess = "not a valid email"
            let alert = UIAlertController(title: "Error Invalid Email", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        else{
            return true
        }
    }
    func checkNumber(num : String) -> Bool{
        let numbersSet = CharacterSet(charactersIn: "0123456789")
        let input = CharacterSet(charactersIn: num)
        if(!input.isSubset(of: numbersSet)){
            let alMess = "Please make sure that you only input the numbers. No dashes or parentheses"
            let alert = UIAlertController(title: "Error with phone number", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        else if(!(num.count >= 9 && num.count <= 15)){
            let alMess = "not a valid length for phone Number"
            let alert = UIAlertController(title: "Error with phone number", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        else{
            return true
        }
        
    }
    
    @IBAction func createFullAcct(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let temp = sb.instantiateViewController(withIdentifier: "Temp") as! TempToRealViewController
        temp.modalPresentationStyle = .fullScreen
        present(temp, animated: true, completion: nil)
    }
    
}
