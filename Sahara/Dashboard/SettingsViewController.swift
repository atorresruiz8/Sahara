//
//  SettingsViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
import Speech
class SettingsViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    
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
            self.searchField.text = search
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
    }
    
    @IBAction func showOrders(_ sender: Any) {
    }
    
    @IBAction func buyAgain(_ sender: Any) {
    }
    
    @IBAction func showWishlist(_ sender: Any) {
    }
    
    @IBAction func showAccount(_ sender: Any) {
    }
    
    @IBAction func showBrowsingHistory(_ sender: Any) {
    }
    
    @IBAction func elecDept(_ sender: Any) {
    }
    
    @IBAction func clothingDept(_ sender: Any) {
    }
    
    @IBAction func outdoorsDept(_ sender: Any) {
    }
    
    @IBAction func cookingDept(_ sender: Any) {
    }
    
    @IBAction func furnitureDept(_ sender: Any) {
    }
    
    @IBAction func textToSpeechSearch(_ sender: Any) {
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
