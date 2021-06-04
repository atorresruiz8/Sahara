//
//  CartViewController.swift
//  Sahara
//
//  Created by Justin Horner on 6/1/21.
//

import UIKit

class CartViewController: UIViewController {
    var mainView : UIView?
    @IBOutlet weak var deliveryAddress: UIButton!
    var subviewSize = 0
        let ud = UserDefaults.standard
        var user : User?
        var prod : Product?
    class cartItem : CustomView{
        let ud = UserDefaults.standard
        var prod : Product?
        var cartItemName: String
        var cartItemPrice: String
        var quantity: Int
        var prodImage : String
        
        init(name: String, price: String, pImage : String) {
            cartItemName = name
            cartItemPrice = price
            quantity = 1
            prodImage = pImage

            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let title = UILabel()
            title.text = cartItemName
            self.addSubview(title)
            let image = UIImageView(image:UIImage(named: prodImage))
            image.frame = CGRect(x: 0, y: 15, width: 100, height: 100)
            self.addSubview(image)
            let quan = UILabel()
            quan.text = String(quantity)
            quan.frame = CGRect(x: 120, y: 80, width: 10, height: 10)
            self.addSubview(quan)
            let add = UIButton()
            let cross = UIImage(systemName: "cross.fill")
            let crossTinted = cross?.withRenderingMode(.alwaysTemplate)
            add.setImage(crossTinted, for: .normal)
            add.tintColor = .black
            add.frame = CGRect(x: 135, y: 80, width: 10, height: 10)
            add.addTarget(self, action: #selector(hi), for: .touchUpInside)
            self.addSubview(add)
            
            let delete = CustomButton()
            delete.setTitle("Delete", for: .normal)
            delete.frame = CGRect(x: 150, y: 75, width: 70, height: 20)
            delete.addTarget(self, action: #selector( deleteCartItem), for: .touchUpInside)
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
        @objc func hi(){
            print("hi")
        }
        @objc func deleteCartItem(){
            print("hi")
            DBHelper.inst.removeFromCart(prodID: prod!.id!, uName: ud.string(forKey: "currUser")!)
            
    }

    }
    func configureSubView(){
        addToCartButton()
        addCartItemsToSubView()
//        setSubViewConstraints()
    }
    var cartArray: [cartItem] = []
    func testCart(){
        cartArray = []
//        cartArray.append(cartItem(name: "Cat", price: "45.55"))
//        cartArray.append(cartItem(name: "Doggo", price: "111.11"))
    }
    var titleLabel = UILabel()
    override func viewDidLoad() {
        mainView = view.subviews[0]
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
        
        for i in 0...user!.cart!.count-1{
            prod = DBHelper.inst.fetchProduct(id: user!.cart![i])
            cartArray.append(cartItem(name: prod!.name!, price: String(format: "$%.2f", prod!.price * prod!.salePercentage), pImage: prod!.image!))
            
        }
        configureSubView()
        print(user!.cart!)
        
        

    }
    func addToCartButton(){
        let button = CustomButton(frame: CGRect(x: 50, y: 175, width: UIScreen.main.bounds.width - 100, height: 50))
        button.setTitle("Proceed to checkout", for: .normal)
        mainView!.addSubview(button)
    }
    func addCartItemsToSubView(){
        for i in 0...cartArray.count-1{// change to cart items
            mainView!.addSubview(cartArray[i])
            mainView!.translatesAutoresizingMaskIntoConstraints = false//
            mainView!.subviews[i+3].frame = CGRect(x: 20, y: (300 + 150 * (i)), width: Int(UIScreen.main.bounds.width) - 40, height: 130)
//            view.subviews[i+1].subviews[0] = CGRect(x:300, y:150, width: view.subviews[i+1].frame.width, height: 100)
            mainView!.subviews[i+3].subviews[0].topAnchor.constraint(equalTo: mainView!.subviews[i+3].topAnchor, constant: 20).isActive = true
            mainView!.subviews[i+3].subviews[0].leadingAnchor.constraint(equalTo: mainView!.subviews[i+3].leadingAnchor, constant: 120).isActive = true

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
