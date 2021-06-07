//
//  CartViewController.swift
//  Sahara
//
//  Created by Justin Horner on 6/1/21.
//

import UIKit
class CartViewController: UIViewController {
    static var deletedItem: Bool = false
    static var cartArray: [cartItem] = []
    @IBOutlet weak var mainView: UIScrollView!
    @IBOutlet weak var deliveryAddress: UIButton!
    var subviewSize = 0
        let ud = UserDefaults.standard
        var user : User?
        var prod : Product?
    static func displayCart(){
        CartViewController.cartArray = []
        let ud2 = UserDefaults.standard
        let user2 = DBHelper.inst.fetchUser(query: ud2.string(forKey: "currUser")!)
        var prod : Product?
        for i in 0...user2!.cart!.count-1{
            
            prod = DBHelper.inst.fetchProduct(id: user2!.cart![i])
            CartViewController.cartArray.append(cartItem(name: prod!.name!, price: String(format: "$%.2f", prod!.price * prod!.salePercentage), pImage: prod!.image!, pIndex: i))
            
        }
        
    }
    
    class cartItem : CustomView{
        let ud = UserDefaults.standard
        var prod : Product?
        var cartItemName: String
        var cartItemPrice: String
        var quantity: Int
        var prodImage : String
        var index: Int
        init(name: String, price: String, pImage : String, pIndex: Int) {
            cartItemName = name
            cartItemPrice = price
            quantity = 1
            prodImage = pImage
            index = pIndex
            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let title = UILabel()
            title.text = cartItemName
            self.addSubview(title)
            let image = UIImageView(image:UIImage(named: prodImage))
            image.frame = CGRect(x: 0, y: 22.5, width: 100, height: 100)
            self.addSubview(image)
            let quan = UILabel()
            quan.text = String(quantity)
            quan.font = UIFont(name: "arial", size: 25)
            quan.frame = CGRect(x: 120, y: 80, width: 10, height: 40)
            self.addSubview(quan)
            let add = UIButton()
            add.setTitle("+", for: .normal)
            add.titleLabel?.font = UIFont(name: "arial", size: 30)
            add.setTitleColor(.black, for: .normal)
//            let cross = UIImage(systemName: "cross.fill")
//            let crossTinted = cross?.withRenderingMode(.alwaysTemplate)
//            add.setImage(crossTinted, for: .normal)
//            add.tintColor = .black
            add.frame = CGRect(x: 125, y: 80, width: 40, height: 40)
            add.addTarget(self, action: #selector(hi), for: .touchUpInside)
            self.addSubview(add)
            let delete = CustomButton()
            delete.setTitle("Delete", for: .normal)
            delete.frame = CGRect(x: 170, y: 75, width: 70, height: 50)
            delete.tag = index
            
            delete.addTarget(self, action: #selector(deleteCartItem), for: .touchUpInside)
            
            self.addSubview(delete)
            let price = UILabel()
            price.text = (String(cartItemPrice))
            price.frame = CGRect(x: 270, y: 60, width: 100, height: 20)
            self.addSubview(price)
            self.sendSubviewToBack(add)
            
            title.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc func hi(words: String){
            print(words)
        }
        @objc func deleteCartItem(sender: UIButton){
            print("hi")
            let user1 = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
            prod = DBHelper.inst.fetchProduct(id: user1!.cart![sender.tag])
            DBHelper.inst.removeFromCart(prodID: prod!.id!, uName: ud.string(forKey: "currUser")!)
            cartArray.remove(at: index)
            CartViewController.deletedItem = true
            print("hello")
        }
    }
    func configureSubView(){
//        addToCartButton()
        addCartItemsToSubView()
//        setSubViewConstraints()
    }

    func testCart(){
        CartViewController.cartArray = []    }
    var titleLabel = UILabel()
    override func viewDidLoad() {
//        testCart()
        
        super.viewDidLoad()
        user = DBHelper.inst.fetchUser(query: ud.string(forKey: "currUser")!)
        
        if (ud.string(forKey: "currUser")!.hasPrefix("_")) {
            deliveryAddress.isHidden = true
        } else {
            if (user!.address != nil) {
                deliveryAddress.setTitle(" Deliver to \(String(describing: user!.name!)) - City: \(String(describing: user!.address!.city)), Zip Code: \(String(describing: user!.address!.zipcode))", for: UIButton.State.normal)
            } else {
                deliveryAddress.setTitle("Deliver to \(String(describing: user!.name!)) - City: N/A, Zip Code: N/A", for: UIButton.State.normal)
            }
        }
        CartViewController.displayCart()
        configureSubView()
        print(user!.cart!)

    }
    override func viewWillAppear(_ animated: Bool) {
        print(CartViewController.deletedItem)
        if(CartViewController.deletedItem == true){
            CartViewController.deletedItem = false
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let cart = sb.instantiateViewController(withIdentifier: "Dash") as! DashboardViewController
                        cart.modalPresentationStyle = .fullScreen
            cart.selectedIndex = 2
                        present(cart, animated: true, completion: nil)
        }
        
    }

//    func addToCartButton(){
//        let button = CustomButton(frame: CGRect(x: 50, y: 175, width: mainView.bounds.width - 100, height: 50))
//        button.setTitle("Proceed to checkout", for: .normal)
//        mainView.addSubview(button)
//        print(mainView.contentSize)
//        mainView!.translatesAutoresizingMaskIntoConstraints = false//
//        print(mainView.subviews)
//    }
    func addCartItemsToSubView(){
                mainView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height + 800)

        for i in 0...CartViewController.cartArray.count-1{// change to cart items
            mainView!.addSubview(CartViewController.cartArray[i])
            mainView!.translatesAutoresizingMaskIntoConstraints = false//
            mainView!.subviews[i+2].frame = CGRect(x: 20, y: (100 + 150 * (i)), width: Int(UIScreen.main.bounds.width) - 40, height: 130)
//            view.subviews[i+1].subviews[0] = CGRect(x:300, y:150, width: view.subviews[i+1].frame.width, height: 100)
//            mainView!.subviews[i+3].subviews[0].topAnchor.constraint(equalTo: mainView!.subviews[i+3].topAnchor, constant: 20).isActive = true
//            mainView!.subviews[i+3].subviews[0].leadingAnchor.constraint(equalTo: mainView!.subviews[i+3].leadingAnchor, constant: 120).isActive = true

        }

        
    }
    func setSubViewConstraints(){
        for i in 1...(mainView!.subviews.count - 1){
            
        }
    func setCartItemConstraints(){
        
    }
    

}

/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
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
