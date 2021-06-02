//
//  MainStoreViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
import Speech
class MainStoreViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var priceOfDailySavings: UILabel!
    @IBOutlet weak var dailySavings: UILabel!
    let ud = UserDefaults.standard
    var user : User?
    static var search = ""
    @IBOutlet weak var dailyDealView: UIView!
    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var inspiredView: UIView!
    @IBOutlet weak var exploreItemView: UIView!
    @IBOutlet weak var deliverToUser: UIButton!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var searchQuery: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var welcomeMessage: UILabel!
    
    let audioEng = AVAudioEngine()
    let speechRecog = SFSpeechRecognizer()
    let req = SFSpeechAudioBufferRecognitionRequest()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    
    func startSpeechRecog() {
        let nd = audioEng.inputNode
        let recordF = nd.outputFormat(forBus: 0)
        
        nd.installTap(onBus: 0, bufferSize: 1024, format: recordF) { (buffer, _) in
            self.req.append(buffer)
        }
        
        audioEng.prepare()
        do {
            try audioEng.start()
        } catch let err {
            print(err)
        }
        
        rTask = speechRecog?.recognitionTask(with: req, resultHandler: { (resp, err) in
            guard resp != nil else {
                if err != nil {
                    print(err.debugDescription)
                } else {
                    print("problem in response")
                }
                return
            }
            
            let search = resp?.bestTranscription.formattedString
            print(search!)
            self.searchQuery.text = search
        })
    }
    
    func cancelSpeechRecog() {
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()
        
        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            welcomeMessage.text = "Hi, Guest"
            deliverToUser.isHidden = true
        } else {
            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            welcomeMessage.text = "Hi, \(String(describing: user!.name!))"
            if (user!.address != nil) {
                deliverToUser.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
            } else {
                deliverToUser.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
            }
        }

        dailyDeal()
    }
    
    func shuffle(array : [Product]) -> [Product] {
        var source = array

        var shuffled = [Product]()
        while source.count > 0 {
            let randomIndex = Int(arc4random()%UInt32(source.count))
            let item = source.remove(at: randomIndex)
            shuffled.append(item)
        }
        return shuffled
    }
    
    func dailyDeal() {
        let rand = "abcdefghijklmnopqrstuvwxyz"
        let randInt = Int.random(in: 0...25)
        let randChar = Array(rand)[randInt]
        var dailyProd = DBHelper.inst.fetchProduct(name: String(randChar))
        dailyProd = dailyProd!.filter({$0.sale == true})
        if (dailyProd!.count == 0) {
            dailyDeal()
            return
        } else {
            dailyProd = shuffle(array: dailyProd!)
        }
        
        dailySavings.text = "Save on " + dailyProd![0].name! + "..."
        priceOfDailySavings.text = "Original " + String(format: "$%.2f", dailyProd![0].price) + "/SALE!!!! " + String(format: "$%.2f", dailyProd![0].price * dailyProd![0].salePercentage)
    }
    
    @IBAction func delivery(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Account", bundle: nil)
        let addr = sb.instantiateViewController(withIdentifier: "Addr") as! AddressUpdateViewController
        addr.modalPresentationStyle = .fullScreen
        present(addr, animated: true, completion: nil)
    }
    
    @IBAction func textToSpeech(_ sender: Any) {
        isStart = !isStart
        if isStart {
            startSpeechRecog()
        } else {
            cancelSpeechRecog()
        }
    }
    
    @IBAction func searchStore(_ sender: Any) {
        MainStoreViewController.search = searchQuery.text!
        DBHelper.inst.addSearchHist(user: ud.string(forKey: "currUser")!, newSt: searchQuery.text!)
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sr = sb.instantiateViewController(withIdentifier: "SearchResults") as! SearchResultsTableViewController
        //sr.modalPresentationStyle = .fullScreen
        present(sr, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            welcomeMessage.text = "Hi, Guest"
            deliverToUser.isHidden = true
        } else {
            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            welcomeMessage.text = "Hi, \(String(describing: user!.name!))"
            if (user!.address != nil) {
                deliverToUser.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
            } else {
                deliverToUser.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
            }
        }
        
        searchQuery.text! = MainStoreViewController.search
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
