//
//  SignUpViewController.swift
//  Sahara
//
//  Created by Peter G on 5/24/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var passText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        print("pressed")
        let numCheck = checkNumber(num: phoneText.text!)
        let emCheck = emailCheck(email: emailText.text!)
        //if both fields are empty
        if(emailText.text == "" && phoneText.text == ""){
            let alMess = "You need to have an email, a phone number, or both."
            let alert = UIAlertController(title: "No sign in method", message: alMess, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        //if email empty and number works
        else if(emailText.text == "" && numCheck){
            print("here")
            
            
        }
        //if number empty and email works
        else if(phoneText.text == "" && emCheck){
            
        }
        //if both email and number works
        else if(numCheck && emCheck){
            
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
   
     
   

}
