//
//  WishListViewController.swift
//  Sahara
//
//  Created by Peter G on 5/26/21.
//

import UIKit



class WishListViewController: UIViewController {
    static var inst = WishListViewController()
    static var wishListArray: [wishListItem] = []
    @IBOutlet weak var mainView: UIScrollView!
    @IBOutlet weak var welcomeMessage: UIButton!
    var subviewSize = 0
        let ud = UserDefaults.standard
        var user : User?
        var prod : Product?
    static func displayWishlist(){
        WishListViewController.wishListArray = []
        let ud2 = UserDefaults.standard
        let user2 = DBHelper.inst.fetchUser(query: ud2.string(forKey: "currUser")!)
        var prod : Product?
        for i in 0...user2!.wishlist!.count-1{
            
            prod = DBHelper.inst.fetchProduct(id: user2!.wishlist![i])
            WishListViewController.wishListArray.append(wishListItem(name: prod!.name!, price: String(format: "$%.2f", prod!.price * prod!.salePercentage), pImage: prod!.image!, pIndex: i))
            
        }
        
    }
    
    class wishListItem : CustomView{
        let ud = UserDefaults.standard
        var prod : Product?
        var WishListItemName: String
        var WishListItemPrice: String
        var prodImage : String
        var index: Int
        init(name: String, price: String, pImage : String, pIndex: Int) {
            WishListItemName = name
            WishListItemPrice = price
            prodImage = pImage
            index = pIndex
            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let title = UILabel()
            title.text = WishListItemName
            self.addSubview(title)
            let image = UIImageView(image:UIImage(named: prodImage))
            image.frame = CGRect(x: 0, y: 22.5, width: 100, height: 100)
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            self.addSubview(image)
            let delete = CustomButton()
            delete.setTitle("Delete", for: .normal)
            delete.frame = CGRect(x: 170, y: 75, width: 70, height: 50)
            delete.tag = index
            
            delete.addTarget(self, action: #selector(deleteWishListItem), for: .touchUpInside)
            self.addSubview(delete)
            let price = UILabel()
            price.text = (String(WishListItemPrice))
            price.frame = CGRect(x: 270, y: 60, width: 100, height: 20)
            self.addSubview(price)
            title.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc func deleteWishListItem(sender: UIButton){
            let user1 = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            prod = DBHelper.inst.fetchProduct(id: user1!.wishlist![sender.tag])
            DBHelper.inst.removeFromWishlist(prodID: prod!.id!, uName: ud.string(forKey: "currUser")!)
            wishListArray.remove(at: index)
            WishListViewController.inst.closeView()
        }
    }
    func closeView(){
        let sb = UIStoryboard(name: "Account", bundle: nil)
        let wish = sb.instantiateViewController(withIdentifier: "Wish") as! WishListViewController
        wish.modalPresentationStyle = .fullScreen
        present(wish, animated: true, completion: nil)
    }
    func configureSubView(){
        addWishlistItemsToSubView()
        
    }
    override func viewDidLoad() {//        testCart()
        
        super.viewDidLoad()
        
        WishListViewController.inst = self
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            welcomeMessage.setTitle("Guest Wishlist", for: UIButton.State.normal)
        } else {
            welcomeMessage.setTitle("Hi, \(String(describing: user!.name!))", for: UIButton.State.normal)
        }
        WishListViewController.displayWishlist()
        configureSubView()
    }

    @IBAction func returnToProfile(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)

        let account = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
        account.modalPresentationStyle = .fullScreen
        account.selectedIndex = 1
        present(account, animated: true, completion: nil)

    }
    func addWishlistItemsToSubView(){
                mainView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 800)

        for i in 0...(WishListViewController.wishListArray.count-1){// change to cart items
            mainView!.addSubview(WishListViewController.wishListArray[i])
            mainView!.translatesAutoresizingMaskIntoConstraints = false//
            mainView!.subviews[i+2].frame = CGRect(x: 20, y: (100 + 150 * (i)), width: Int(UIScreen.main.bounds.width) - 40, height: 130)
//            view.subviews[i+1].subviews[0] = CGRect(x:300, y:150, width: view.subviews[i+1].frame.width, height: 100)
//            mainView!.subviews[i+3].subviews[0].topAnchor.constraint(equalTo: mainView!.subviews[i+3].topAnchor, constant: 20).isActive = true
//            mainView!.subviews[i+3].subviews[0].leadingAnchor.constraint(equalTo: mainView!.subviews[i+3].leadingAnchor, constant: 120).isActive = true

        }

        
    }
    

}


