//
//  PaymentMakerViewController.swift
//  Sahara
//
//  Created by admin on 6/8/21.
//

import UIKit

class PaymentMakerViewController: UIViewController {
    @IBOutlet weak var routNum: UITextField!
    let ud = UserDefaults.standard
    @IBOutlet weak var CCN: UITextField!
    @IBOutlet weak var cName: UITextField!
    @IBOutlet weak var CCV: UITextField!
    @IBOutlet weak var monthExp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addCreditCard(_ sender: Any) {
        if(cName.text != "" && CCN.text !=  "" && CCN.text!.count == 16 && CCV.text != "" && CCV.text!.count == 3 && monthExp.text != ""){
            DBHelper.inst.makeCreditCard(uName: ud.string(forKey: "currUser")!, cName: cName.text!, cNum: CCN.text!, cExDate: monthExp.text!, ccv: CCV.text!)
        }
        else{
            let alert = UIAlertController(title: "Invalid Information", message: "there was a problem with some of hte information that you provided", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addRoutNum(_ sender: Any) {
        if(routNum.text != ""){
            DBHelper.inst.setNetBanking(uName: ud.string(forKey: "currUser")!, rout: routNum.text!)
        }
        else{
            let alert = UIAlertController(title: "Invalid Information", message: "there was a problem with some of hte information that you provided", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Try Again", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
