//
//  ProductMaker.swift
//  Sahara
//
//  Created by Peter G on 5/28/21.
//


import Foundation
class ProductCreation{
    let names = ["Camping Chair", "Grill", "Uninteruptable power source", "macBook Air", "GUCCI handbag", "Playstation 5", "Nonstick Cooking Pan", "Me and the Boys Beans Shirt", "Horse Mask", "Zebra mask", "Re Zero Rem Girl's Anime Body Pillow", "wireless mouse", "SSD External Storage", "Health Mask", "Sad Frog Plushie", "Segway smart self-balance", " Nintendo Switch Pro", "Gaming Office Chair", "Table", "Blue Yeti Microphone", "Mic Stand with Pop Filter", "Dual Monitor Adjustable Vesa Stand", "Florida Man Cooking Book", "Go the F to Sleep by Adam Mansback", "Kiddie Pool for Pets", "The Nut Button Toy", "OK Boomer Button Toy", "Xbox 720", "Soulja Boy Game Console", "SkyTech Shadow Gaming PC"]
    let OrigPrice = [55.99, 199.00, 55.99, 999.00, 1799.99, 499.99, 27.99, 17.99, 13.95, 13.95,39.85,9.99,114.99,7.80,17.85,539,9999999.99,220,50.00,105.00,25.99,57.99,6.97,12.25,42.99,19.99,14.99,720.69,98.98,1337.99]
    let sale = [false, true, false, true, false, false, true, false, false, false, false,false, false, false, false, true, true, true, false, true, true, false, false, false, false, false, false, false, false, false]
    let salePercent = [1, 0.85, 1, 0.95, 1, 1, 0.70, 1, 1, 1, 1, 1, 1, 1, 1, 0.83, 0.000042, 0.95, 1, 0.80, 0.66, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    let tags = [["Outdoors", "Decorations"],["Outdoors", "Cooking", "Decorations"], ["Electronics", "Decorations"], ["Electronics", "Decorations"], ["Clothing", "Decorations"], ["Electronics", "Decorations"], ["Cooking", "Decorations"], ["Electronics", "Outdoors", "Clothing", "Cooking", "Decorations"], ["Clothing", "Decorations"], ["Clothing", "Decorations"], ["Decorations"], ["Electronics", "Decorations"], ["Electronics", "Decorations"],  ["Clothing", "Decorations"], ["Decorations"], ["Electronics", "Outdoors", "Decorations"], ["Electronics", "Outdoors", "Decorations"],  ["Electronics", "Decorations"], ["Outdoors", "Decorations"], ["Electronics", "Decorations"], ["Electronics", "Decorations"], ["Electronics", "Decorations"], ["Outdoors", "Cooking", "Decorations"], ["Outdoors", "Decorations"], ["Outdoors", "Decorations"], ["Decorations"], ["Decorations"], ["Electronics", "Decorations"], ["Electronics", "Cooking", "Decorations"], ["Electronics", "Cooking", "Decorations"]]
    func remakeAll(){
        //DBHelper.inst.clearProducts()
        for i in 1...names.count{
            //DBHelper.inst.makeProduct(name: names[i-1], price: price[i-1], sale : sale[i-1], saleP : salePercent[i-1], tags: tags[i-1])
            
        }
    }
}


