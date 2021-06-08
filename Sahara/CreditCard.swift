//
//  CreditCard.swift
//  Sahara
//
//  Created by admin on 6/8/21.
//

import Foundation

public class CreditCard : NSObject, NSCoding{
    var name : String = ""
    var number : String = ""
    var expDate : String = ""
    var CCV : String = ""
  
    init(name : String, number : String, expDate : String, CCV : String){
        self.name = name
        self.number = number
        self.expDate = expDate
        self.CCV = CCV
      
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(number, forKey: "number")
        coder.encode(expDate, forKey: "expDate")
        coder.encode(CCV, forKey: "CCV")
     
    }
    
    required public init?(coder decod: NSCoder) {
        self.name = decod.decodeObject(forKey: "name") as! String
        self.number = decod.decodeObject(forKey: "number") as! String
        self.expDate = decod.decodeObject(forKey: "expDate") as! String
        self.CCV = decod.decodeObject(forKey: "CCV") as! String
       
        
    }
    
}
