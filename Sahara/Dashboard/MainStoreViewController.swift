//
//  MainStoreViewController.swift
//  Sahara
//
//  Created by Antonio Torres-Ruiz on 5/24/21.
//

import UIKit
import Speech
import DropDown
class MainStoreViewController: UIViewController, SFSpeechRecognizerDelegate {
    @IBOutlet weak var dropDownView: UIView!
    var exploreProd : [Product] = []
    var dailyProd : [Product] = []
    var wishProd : [Product] = []
    var recentProd : Product?
    
    @IBOutlet weak var recentIMG: UIImageView!
    @IBOutlet weak var wishlistItemsIMG: UIImageView!
    @IBOutlet weak var exploreItemsIMG: UIImageView!
    @IBOutlet weak var dailyDealPic: UIImageView!
    @IBOutlet weak var priceOfDailySavings: UILabel!
    @IBOutlet weak var dailySavings: UILabel!
    
    let ud = UserDefaults.standard
    var user : User?
    static var search = ""
    let dropDown = DropDown()
    
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
            
            let search = resp?.bestTranscription.formattedString.lowercased()
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
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        // Do any additional setup after loading the view.
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            welcomeMessage.text = "Hi, Guest"
            deliverToUser.isHidden = true
        } else {
            welcomeMessage.text = "Hi, \(String(describing: user!.name!))"
            if (user!.address != nil) {
                deliverToUser.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
            } else {
                deliverToUser.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
            }
        }

        dailyDeal()
        exploreItems()
        wishlistItems()
        recentItems()
        
        let dailyTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            dailyDealPic.isUserInteractionEnabled = true
            dailyDealPic.addGestureRecognizer(dailyTap)
        
        let exploreTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            exploreItemsIMG.isUserInteractionEnabled = true
            exploreItemsIMG.addGestureRecognizer(exploreTap)
        
        let wishlistTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            wishlistItemsIMG.isUserInteractionEnabled = true
            wishlistItemsIMG.addGestureRecognizer(wishlistTap)
        
        let recentTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            recentIMG.isUserInteractionEnabled = true
            recentIMG.addGestureRecognizer(recentTap)
        
        dropDown.anchorView = dropDownView
        dropDown.direction = .any
        dropDown.dataSource = ["#tech", "#clothing", "#cooking", "#outdoor", "#decoration"]
        
        
        searchQuery.addTarget(self, action: #selector(MainStoreViewController.textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange() {
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            searchQuery.text = item
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // check to see which image was tapped to determine which product to load
        switch tappedImage.image {
        case dailyDealPic.image:
            ud.setValue(dailyProd[0].id, forKey: "currProd")
        case exploreItemsIMG.image:
            ud.setValue(exploreProd[0].id, forKey: "currProd")
        case wishlistItemsIMG.image:
            ud.setValue(wishProd[0].id, forKey: "currProd")
        case recentIMG.image:
            ud.setValue(recentProd!.id, forKey: "currProd")
        default:
            print("no view was pushed")
        }

        // instantiate the view controller with the current product
        let sb : UIStoryboard = UIStoryboard(name: "Payment", bundle: nil)
        let prod = sb.instantiateViewController(withIdentifier: "Product") as! ProductViewController
        prod.modalPresentationStyle = .fullScreen
        present(prod, animated: true, completion: nil)
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
        dailyProd = DBHelper.inst.fetchProduct(name: String(randChar))!
        dailyProd = dailyProd.filter({$0.sale == true})
        if (dailyProd.count == 0) {
            dailyDeal()
            return
        } else {
            dailyProd = shuffle(array: dailyProd)
        }
        
        dailySavings.text = "Save on... " + dailyProd[0].name! + "!"
        priceOfDailySavings.text = "Original " + String(format: "$%.2f", dailyProd[0].price) + "/Currently " + String(format: "$%.2f", dailyProd[0].price * dailyProd[0].salePercentage)
        dailyDealPic.image = UIImage(named: dailyProd[0].image!)
        dailyDealPic.contentMode = .scaleAspectFit
        
        ud.setValue(dailyProd[0].id, forKey: "currProd")
    }
    
    func exploreItems() {
        let rand = "abcdefghijklmnopqrstuvwxyz"
        let randInt = Int.random(in: 0...25)
        let randChar = Array(rand)[randInt]
        exploreProd = DBHelper.inst.fetchProduct(name: String(randChar))!
        if (exploreProd.count == 0) {
            exploreItems()
            return
        } else {
            exploreProd = shuffle(array: exploreProd)
        }
        exploreItemsIMG.image = UIImage(named: exploreProd[0].image!)
        exploreItemsIMG.contentMode = .scaleAspectFit
        
        ud.setValue(exploreProd[0].id, forKey: "currProd")
    }
    
    func wishlistItems() {
        if (user!.wishlist!.count == 0) {
            wishlistItemsIMG.image = UIImage(named: "SaharaLogo")
        } else {
            // Used to display a random item from each of the 5 tags
            let randElec = Int.random(in: 0...DBHelper.inst.electronics.count - 1)
            let randOut = Int.random(in: 0...DBHelper.inst.outdoors.count - 1)
            let randCloth = Int.random(in: 0...DBHelper.inst.clothing.count - 1)
            let randCook = Int.random(in: 0...DBHelper.inst.cooking.count - 1)
            let randDeco = Int.random(in: 0...DBHelper.inst.decorations.count - 1)
            
            // first item in your wishlist
            let wp = user!.wishlist![0]
            
            // fetch a product with the same id as the first item in your wishlist
            let w = DBHelper.inst.fetchProduct(id: wp)
            
            // check which tag the item has in its first tag slot and then add a random object from said tag
            if (w!.tags![0].contains("Electronics")) {
                wishProd.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.electronics[randElec])!)
            } else if (w!.tags![0].contains("Outdoors")) {
                wishProd.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.outdoors[randOut])!)
            } else if (w!.tags![0].contains("Clothing")) {
                wishProd.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.clothing[randCloth])!)
            } else if (w!.tags![0].contains("Cooking")) {
                wishProd.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.cooking[randCook])!)
            } else if (w!.tags![0].contains("Decorations")) {
                wishProd.append(DBHelper.inst.fetchProduct(id: DBHelper.inst.decorations[randDeco])!)
            }
            
            // display a random product from your related first item in wishlist's tags
            wishlistItemsIMG.image = UIImage(named: wishProd[0].image!)
            wishlistItemsIMG.contentMode = .scaleAspectFit
            ud.setValue(wishProd[0].id, forKey: "currProd")
        }
    }
    
    func recentItems() {
        if (ud.string(forKey: "lastProd") != nil) {
            recentProd = DBHelper.inst.fetchProduct(id: ud.string(forKey: "lastProd")!)
            recentIMG.image = UIImage(named: recentProd!.image!)
            recentIMG.contentMode = .scaleAspectFit
            ud.setValue(recentProd!.id, forKey: "currProd")
        } else {
            recentIMG.image = UIImage(named: "SaharaLogo")
        }
        
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
        searchQuery.text = ""
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
