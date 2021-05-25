//
//  address.swift
//  Sahara
//
//  Created by Peter G on 5/24/21.
//

import Foundation

public class Address : NSObject, NSCoding{
    var street : String = ""
    var city : String = ""
    var state : String = ""
    var country : String = ""
    var zipcode : String = ""
    
    init(street : String, city : String, state : String, country : String, zipcode : String){
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zipcode = zipcode
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(street, forKey: "street")
        coder.encode(city, forKey: "city")
        coder.encode(state, forKey: "state")
        coder.encode(country, forKey: "country")
        coder.encode(zipcode, forKey: "zaipcode")
    }
    
    required public init?(coder decod: NSCoder) {
        self.street = decod.decodeObject(forKey: "street") as! String
        self.city = decod.decodeObject(forKey: "city") as! String
        self.state = decod.decodeObject(forKey: "state") as! String
        self.country = decod.decodeObject(forKey: "country") as! String
        self.zipcode = decod.decodeObject(forKey: "zipcode") as! String
        
    }
    
}

