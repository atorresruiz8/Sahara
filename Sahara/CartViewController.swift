//
//  CartViewController.swift
//  Sahara
//
//  Created by Justin Horner on 6/1/21.
//

import UIKit

class CartViewController: UIViewController {
    var subviewSize = 0
    class cartItem : UIView{
        var cartItemName: String
        var cartItemPrice: Double
        var quantity: Int
        
        init(name: String, price: Double) {
            cartItemName = name
            cartItemPrice = price
            quantity = 1

            super.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 100, height: 100))
            let title = UILabel()
            title.text = cartItemName
            self.addSubview(title)
            let image = UIImageView(image:UIImage(named: "Doge"))
            image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.addSubview(image)
            let quan = UILabel()
            quan.text = String(quantity)
            quan.frame = CGRect(x: 100, y: 80, width: 10, height: 10)
            self.addSubview(quan)
            let add = UIButton()
            let cross = UIImage(systemName: "cross.fill")
            let crossTinted = cross?.withRenderingMode(.alwaysTemplate)
            add.setImage(crossTinted, for: .normal)
            add.tintColor = .black
            add.frame = CGRect(x: 115, y: 80, width: 10, height: 10)
            self.addSubview(add)
            let delete = UIButton()
            delete.setTitle("Delete", for: .normal)
            delete.frame = CGRect(x: 130, y: 80, width: 70, height: 20)
            self.addSubview(delete)
            let price = UILabel()
            price.text = ("$" + String(cartItemPrice))
            price.frame = CGRect(x: 250, y: 60, width: 100, height: 20)
            self.addSubview(price)

            
            title.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
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
        cartArray.append(cartItem(name: "Cat", price: 45.55))
        cartArray.append(cartItem(name: "Doggo", price: 111.11))
    }
    var titleLabel = UILabel()
    override func viewDidLoad() {
        testCart()
        configureSubView()
        super.viewDidLoad()
        

    }
    func addToCartButton(){
        let button = UIButton(frame: CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: 100))
        button.setTitle("Proceed to checkout", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
    }
    func addCartItemsToSubView(){
        for i in 0...cartArray.count-1{// change to cart items
            cartArray[i].backgroundColor = .red
            view.addSubview(cartArray[i])
            view.translatesAutoresizingMaskIntoConstraints = false//
            view.subviews[i+1].frame = CGRect(x: 50, y: (200 + 150 * (i)), width: Int(UIScreen.main.bounds.width) - 100, height: 100)
            print(view.subviews[i+1].subviews[1])
//            view.subviews[i+1].subviews[0] = CGRect(x:300, y:150, width: view.subviews[i+1].frame.width, height: 100)
            view.subviews[i+1].subviews[0].topAnchor.constraint(equalTo: view.subviews[i+1].topAnchor, constant: 20).isActive = true
            view.subviews[i+1].subviews[0].leadingAnchor.constraint(equalTo: view.subviews[i+1].leadingAnchor, constant: 100).isActive = true

        }

        
    }
    func setSubViewConstraints(){
        for i in 1...(view.subviews.count - 1){
            
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
