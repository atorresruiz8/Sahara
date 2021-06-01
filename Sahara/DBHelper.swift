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
    var electronics : [String]?
    var outdoors : [String]?
    var clothing : [String]?
    var cooking : [String]?
    var decorations : [String]?
    func addNewUser(object : [String:String]){
        
       
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.balance = 0.0
        
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
        var fetchReq = NSFetchRequest<NSManagedObject>(entityName: "User")
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
        var currUser = fetchUser(query: user)
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
    func addProduct(price : Double, name : String, tags : [String], sale : Bool, salePerc : Double){
        var id : Int
        var idChecked = false
        repeat{
            id = Int.random(in: 1000000...9999999)
            let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Product")
            fetchReq.predicate = NSPredicate(format: "id == %@", id)
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
        do{
            try context!.save()
            print("data saved")
            if(tags.contains("electronics")){
                if(electronics != nil){
                    electronics!.append(prod.id!)
                }
                else{
                    electronics = [prod.id!]
                }
            }
            if(tags.contains("outdoors")){
                if(outdoors != nil){
                    outdoors!.append(prod.id!)
                }
                else{
                    outdoors = [prod.id!]
                }
            }
            if(tags.contains("clothing")){
                if(clothing != nil){
                    clothing!.append(prod.id!)
                }
                else{
                    clothing = [prod.id!]
                }
            }
            if(tags.contains("cooking")){
                if(cooking != nil){
                    cooking!.append(prod.id!)
                }
                else{
                    cooking = [prod.id!]
                }
            }
            if(tags.contains("decorations")){
                if(decorations != nil){
                    decorations!.append(prod.id!)
                }
                else{
                    decorations = [prod.id!]
                }
            }

        }
        catch{
            print("data not saved")
        }
    }
}
