//
//  CartTableViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
import Speech
class CartTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSpeechRecognizerDelegate {
    let ud = UserDefaults.standard
    var user : User?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var deliveryAddress: UIButton!
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            deliveryAddress.isHidden = true
        } else {
            user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            
            deliveryAddress.setTitle("Deliver to \(String(describing: user!.name!)) - [City, Zip Code]", for: UIButton.State.normal)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Cart is empty."
        return cell
    }
    
    @IBAction func textToSpeechSearch(_ sender: Any) {
        isStart = !isStart
        if isStart {
            startSpeechRecog()
        } else {
            cancelSpeechRecog()
        }
    }
    
    @IBAction func purchase(_ sender: Any) {
        
    }
    
    @IBAction func deliveryAddress(_ sender: Any) {
        
    }
    
    @IBAction func searchStore(_ sender: Any) {
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
