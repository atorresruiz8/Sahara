//
//  DBHelper.swift
//  Sahara
//
//  Created by Peter on 5/24/21.
//

import Foundation
import CoreData
import UIKit

class DBHelper{
    static var inst = DBHelper()
    static var dataCheck = false
    var ud = UserDefaults.standard
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var electronics : [String] = []
    var outdoors : [String] = []
    var clothing : [String] = []
    var cooking : [String] = []
    var decorations : [String] = []
    func addNewUser(object : [String:String]){
        
       
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.balance = 0.0
        user.wishlist = []
        user.cart = []
        
        if((object["email"]) != nil){
            user.email = object["email"]
        }
        if((object["phoneNumber"]) != nil){
            user.phoneNumber = object["phoneNumber"]
        }
        user.name = object["name"]
        user.password = object["password"]
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func addTempUser() -> String{
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        let randInt = Int.random(in: 1000000...9999999)
        user.name = "_" + String(randInt)
        user.wishlist = []
        user.cart = []
        
        do{
            try context!.save()
            ud.setValue(user.name, forKey: "currUser")
            print("data saved")
            return user.name!
        }
        catch{
            print("data not saved")
            return "error"
        }
        
    }
    func TempToUser(object : [String : String]) {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        let query = ud.string(forKey: "currUser")!
        fetchReq.predicate = NSPredicate(format: "name == %@", query)
        do{
            let usr = try context!.fetch(fetchReq) as! [User]
            let user = usr[0]
            user.name = object["name"]
            if((object["email"]) != nil){
                user.email = object["email"]
            }
            if((object["phone"]) != nil){
                user.phoneNumber = object["phoneNumber"]
            }
            user.password = object["password"]
            user.balance = 0.0
            do{
                try context!.save()
                print("data saved")
            }
            catch{
                print("data not saved")
            }
           
            
        }
        catch{
            print("error fetching user")
        }
        
    }
    func validateEmailPass(uName : String, uPass : String) -> Bool{
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        do{
            fetchReq.predicate =  NSPredicate(format: "email == %@", uName)
            //print("asdf")
            let usr = try context!.fetch(fetchReq)
            for data in usr {
                let user = data as! User
                //print("user" + uPass + " " + user.password!)
                if(uName == user.email && uPass == user.password){
                    DBHelper.dataCheck = true
                    return true}
                else{continue}
            }
            DBHelper.dataCheck = false
            return false
        }
        catch{
            return false
        }
    }
    func validatePhonePass(uName : String, uPass : String) -> Bool{
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        do{
            fetchReq.predicate =  NSPredicate(format: "phoneNumber == %@", uName)
            let usr = try context!.fetch(fetchReq)
            for data in usr {
                let user = data as! User
                if(uName == user.phoneNumber && uPass == user.password){
                    DBHelper.dataCheck = true
                    return true}
                else{continue}
            }
            DBHelper.dataCheck = false
            return false
        }
        catch{
            return false
        }
    }
    func fetchUser(query : String) -> User?
    {
        if(query.prefix(1) == "_"){
            print("temp")
            return DBHelper.inst.fetchTempUser(query: query)
        }
        if(query.contains("@")){
            return DBHelper.inst.fetchEmailUser(query: query)
       
        }
        else{
            return DBHelper.inst.fetchPhoneUser(query: query)
        }
    }
    func fetchTempUser(query : String) -> User?{
        var neededUser : User?
        DBHelper.dataCheck = false
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "name == %@", query)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.name == query){
                    neededUser = data
                    DBHelper.dataCheck = true
                    return neededUser
                }
                else {
                    continue
                }
            }
            return neededUser
        }
        catch{
            return neededUser
        }
        
    }
    func fetchEmailUser( query : String) -> User?{
        var neededUser : User?
        DBHelper.dataCheck = false
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "email == %@", query)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.email == query){
                    neededUser = data
                    DBHelper.dataCheck = true
                    return neededUser
                }
                else {
                    continue
                }
            }
            return neededUser
        }
        catch{
            return neededUser
        }
    }
    func fetchPhoneUser( query : String) -> User?{
        var neededUser : User?
        DBHelper.dataCheck = false
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "phoneNumber == %@", query)
        do{
            let usr = try context!.fetch(fetchReq)
            let users = usr as! [User]
            for data in users{
                if(data.phoneNumber == query){
                    neededUser = data
                    DBHelper.dataCheck = true
                    return neededUser
                }
                else {
                    continue
                }
            }
            return neededUser
        }
        catch{
            return neededUser
        }
    }
    func clearHistory(query : User){
        
        query.searchHistory = []
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func updateInfo(user : User, object : [String : String]){
        if(object.keys.contains("phoneNumber")){
            user.phoneNumber = object["phoneNumber"]
        }
        if(object.keys.contains("email")){
            user.email = object["email"]
        }
        if(object.keys.contains("name")){
            user.name = object["name"]
        }
        if(object.keys.contains("pass")){
            user.password = object["pass"]
        }
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func updateAddress(user : String, add : Address){
        let user = fetchUser(query: user)
        user!.address = add
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func clearSearchHist(user : User){
        user.searchHistory = []
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func addSearchHist(user : String, newSt : String){
        let currUser = fetchUser(query: user)
        if((currUser!.searchHistory) != nil){
            currUser!.searchHistory!.append(newSt)
        }
        else{
            currUser!.searchHistory = [newSt]
        }
       
        do{
            try context!.save()
            print("data saved")
        }
        catch{
            print("data not saved")
        }
    }
    func addProduct(price : Double, name : String, tags : [String], sale : Bool, salePerc : Double, image : String){
        var id : Int
        var idChecked = false
        repeat{
            id = Int.random(in: 1000000...9999999)
            let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
            fetchReq.predicate = NSPredicate(format: "id == %@", String(id))
            do{
                let usr = try context!.fetch(fetchReq)
                let users = usr as! [Product]
                idChecked = !(users.count > 0)
            } 
            catch{
               idChecked = true
            }
        }while(!idChecked)
        let prod = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context!) as! Product
        prod.id = String(id)
        prod.price = price
        prod.name = name
        prod.tags = tags
        prod.sale = sale
        prod.salePercentage = salePerc
        prod.image = image
        do{
            try context!.save()
            print("data saved")
            if(tags.contains("Electronics")){
                electronics.append(prod.id!)
            }
            if(tags.contains("Outdoors")){
                outdoors.append(prod.id!)
            }
            if(tags.contains("Clothing")){
                clothing.append(prod.id!)
            }
            if(tags.contains("Cooking")){
                cooking.append(prod.id!)
            }
            if(tags.contains("Decorations")){
                decorations.append(prod.id!)
            }
            
            print(String(id))

        }
        catch{
            print("data not saved")
        }
    }
    
    func arrayMaker() {
        if (decorations.count != 0) {
            return
        }
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
        do {
            let res = try context!.fetch(fetchReq) as! [Product]
            for prod in res {
                if(prod.tags!.contains("Electronics")){
                    electronics.append(prod.id!)
                }
                if(prod.tags!.contains("Outdoors")){
                    outdoors.append(prod.id!)
                }
                if(prod.tags!.contains("Clothing")){
                    clothing.append(prod.id!)
                }
                if(prod.tags!.contains("Cooking")){
                    cooking.append(prod.id!)
                }
                if(prod.tags!.contains("Decorations")){
                    decorations.append(prod.id!)
                }
            }
        } catch {
            print("data not saved")
        }
    }
    
    func checkProducts() {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
        do {
            let res = try context!.fetch(fetchReq) as! [Product]
            if (res.count == 0) {
                let mp = ProductCreator()
                mp.remakeAll()
            }
        } catch {
            print("data not saved")
        }
    }
    
    func updateBalance(amount: Double, query: String) {
        let user = fetchUser(query: query)
        user!.balance += amount
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func fetchProduct(id: String)->Product? {
        var p : Product?
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
        fetchReq.predicate = NSPredicate(format: "id == %@", id)
        do{
            let prod = try context!.fetch(fetchReq)
            let prods = prod as! [Product]
            
            if (prods.count != 0) {
                p = prods[0]
            }
        }
        catch{
           print("data not fetched")
        }
        
        return p
    }
    
    func addToWishlist(prodID : String, uName : String){
        let user = fetchUser(query: uName)
        
        user!.wishlist! = user!.wishlist! + [prodID]
        
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func fetchProduct(name: String)->[Product]? {
        var p : [Product]?
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
        fetchReq.predicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        do{
            let prod = try context!.fetch(fetchReq)
            p = prod as? [Product]
        }
        catch{
           print("data not fetched")
        }
        
        return p
    }
    
    func removeFromWishlist(prodID : String, uName : String){
        let user = fetchUser(query: uName)
        user!.wishlist = user!.wishlist!.filter({$0 != prodID})

        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func addReview(prod: Product, usr: User, review: String, rating: Double) {
        let r = NSEntityDescription.insertNewObject(forEntityName: "Review", into: context!) as! Review
        r.comment = review
        r.rating = rating
        r.user = usr
        r.product = prod
        
        prod.addToReview(r)
        usr.addToReview(r)
        
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func addToCart(prodID : String, uName : String){
        let user = fetchUser(query: uName)
        
        user!.cart! = user!.cart! + [prodID]
        
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }

    func removeFromCart(prodID: String, uName: String) {
        let user = fetchUser(query: uName)
        user!.cart = user!.cart!.filter({$0 != prodID})

        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func addBoughtProduct(uName: String, pID: String){
        let bp = NSEntityDescription.insertNewObject(forEntityName: "BoughtProduct", into: context!) as! BoughtProduct
        bp.trackingStatus = "Sahara Distribution Center"
        bp.amount = 1
        let user = DBHelper.inst.fetchUser(query: uName)
        let prod = DBHelper.inst.fetchProduct(id: pID)
        bp.owner = user
        bp.price = (prod!.price * prod!.salePercentage)

        let currDate = Date()
        var dateComp = DateComponents()
        dateComp.day = 7
        let futureDate = Calendar.current.date(byAdding: dateComp, to: currDate)
        bp.deliveryDate = futureDate
        bp.image = prod!.image!
        bp.name = prod!.name!
        let randInt = Int.random(in: 100000000...999999999)
        bp.bProdID = String(randInt)
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    
    func fetchBoughtProduct(boughtProdID: String)->BoughtProduct? {
        var b: BoughtProduct?
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "BoughtProduct")
        fetchReq.predicate = NSPredicate(format: "bProdID == %@", boughtProdID)
        do {
            let bProd = try context!.fetch(fetchReq)
            let bProds = bProd as! [BoughtProduct]
            for data in bProds{
                if(data.bProdID == boughtProdID){
                    b = data
                    DBHelper.dataCheck = true
                    return b
                }
            }
        } catch {
            print("data not fetched")
        }
        
        return b
    }
    
    func fetchBoughtProduct(uName: String)->[BoughtProduct]? {
        var b: [BoughtProduct]?
        let user = DBHelper.inst.fetchUser(query: uName)
        let array = user!.bought!.allObjects as! [BoughtProduct]
        b = array
        return b
    }
    
    func refundProduct(boughtProdID: String, uName: String) {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "BoughtProduct")
        fetchReq.predicate = NSPredicate(format: "bProdID == %@", boughtProdID)
        let user = DBHelper.inst.fetchUser(query: uName)
        let bProd = DBHelper.inst.fetchBoughtProduct(boughtProdID: boughtProdID)!
        user!.balance += bProd.price
        do {
            context!.delete(bProd)
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
    func fetchCurrentOrder(uNam: String) ->[BoughtProduct]?{
        var prods = DBHelper.inst.fetchBoughtProduct(uName: uNam)
        prods!.filter{$0.trackingStatus != "Delivered!"}
        return prods
    }
    func progressTracking(boughtID : String){
        var prod = DBHelper.inst.fetchBoughtProduct(boughtProdID: boughtID)
        if(prod!.trackingStatus == "Sahara Distribution Center"){
            prod!.trackingStatus = "On its way!"
        }
        else if(prod!.trackingStatus == "On its way!"){
            prod!.trackingStatus = "Delivered!"
        }
        else{
            print("this product has already been delivered")
        }
        do {
            try context!.save()
            print("data saved")
        } catch {
            print("data not saved")
        }
    }
}
