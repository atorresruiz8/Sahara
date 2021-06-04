//
//  SignUpViewController.swift
//  Sahara
//
//  Created by Peter G on 5/24/21.
//

import UIKit
import CryptoKit
class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        print("pressed")
        var emCheck = false
        if(!(emailText.text == "")){
            emCheck = emailCheck(email: emailText.text!)
            DBHelper.inst.fetchUser(query: emailText.text!)
            if(DBHelper.dataCheck){
                let alMess = "A user with that email already exists."
                let alert = UIAlertController(title: "Can't Sign up", message: alMess, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
                
            }
        }
        var numCheck = false
        if(!(phoneText.text == "")){
            numCheck = checkNumber(num: phoneText.text!)
            DBHelper.inst.fetchUser(query:phoneText.text!)
            if(DBHelper.dataCheck){
                let alMess = "A user with that phone number already exists."
                let alert = UIAlertController(title: "Can't Sign up", message: alMess, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
                
            }
        }
        if(passText.text!.count < 6){
            let alMess = "please make sure that your password has at least 6 characters."
            let alert = UIAlertController(title: "Password too short", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        var inputString :String?
        var inputData : Data?
        var hashed : SHA256.Digest
        var object : [String : String]
        //if both fields are empty
        if(nameField.text == ""){
            let alMess = "Please input a name."
            let alert = UIAlertController(title: "No Name", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        if(emailText.text == "" && phoneText.text == ""){
            let alMess = "You need to have an email, a phone number, or both."
            let alert = UIAlertController(title: "No sign in method", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }
        //if email empty and number works
        else if(emailText.text == "" && numCheck){
            print("here")
            inputString = passText.text!  + "423"
            
            inputData = Data(inputString!.utf8)
            hashed = SHA256.hash(data: inputData!)
            object = ["phoneNumber" : phoneText.text!, "name" : nameField.text!, "password" : String(describing : hashed)]
         
            DBHelper.inst.addNewUser(object: object)
            
            
        }
        //if number empty and email works
        else if(phoneText.text == "" && emCheck){
            inputString = passText.text! + "423"
            
            inputData = Data(inputString!.utf8)
            hashed = SHA256.hash(data: inputData!)
            object = ["email" : emailText.text!, "name" : nameField.text!, "password" : String(describing : hashed)]
            
            DBHelper.inst.addNewUser(object: object)
        }
        //if both email and number works
        else if(numCheck && emCheck){
            inputString = passText.text! + "423"
            
            inputData = Data(inputString!.utf8)
            hashed = SHA256.hash(data: inputData!)
            object = ["email" : emailText.text!, "phoneNumber" : phoneText.text!, "name" : nameField.text!, "password" : String(describing : hashed)]
           
            DBHelper.inst.addNewUser(object: object)
        }
        //if we can't make a new user
        else{
            print("bad inputs")
        }
        
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
        if(newEm[0].count == 0 || newEm[1].count == 0 || newEm[0].hasPrefix("_")){
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
   
     
   

}
