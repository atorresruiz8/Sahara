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

    func addNewUser(object : [String:String]){
        
       
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.balance = 0.0
        
        if((object["email"]) != nil){
            user.email = object["email"]
        }
        if((object["address"]) != nil){
            user.address = object["address"]
        }
        if((object["phone"]) != nil){
            user.address = object["phone"]
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
    func addTempUser(){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        let randInt = Int.random(in: 1000000...9999999)
        user.name = String(randInt)
        
        do{
            try context!.save()
            ud.setValue(user.name, forKey: "currUser")
            print("data saved")
        }
        catch{
            print("data not saved")
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
            if((object["address"]) != nil){
                user.address = object["address"]
            }
            if((object["phone"]) != nil){
                user.address = object["phone"]
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
            let usr = try context!.fetch(fetchReq)
            for data in usr {
                let user = data as! User
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
    func fetcheEmailUser( query : String) -> User?{
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
    func fetchePhoneUser( query : String) -> User?{
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
}
