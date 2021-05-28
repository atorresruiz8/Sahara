//
//  MainStoreViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
import Speech
class MainStoreViewController: UIViewController, SFSpeechRecognizerDelegate {

    let ud = UserDefaults.standard
    var user : User?
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
            
            deliverToUser.setTitle("Deliver to \(String(describing: user!.name!)) - [City, Zip Code]", for: UIButton.State.normal)
        }

    }
    
    @IBAction func delivery(_ sender: Any) {
        
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
