//
//  ExcelRow.swift
//  SLSFlasher
//
//  Created by ACoding on 11/9/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class ExcelRow: NSObject, NSCoding {
    var columnA : String?
    var columnB : String?
    var columnG : String?
    var columnH : String?
    var columnI : String?
    var columnK : String?
    var columnN : String?
    
    override init() {
        var columnA = ""
        var columnB = ""
        var columnG = ""
        var columnH = ""
        var columnI = ""
        var columnK = ""
        var columnN = ""
    }
    
    required init(coder decoder: NSCoder){
        columnA = decoder.decodeObject(forKey: "a") as? String ?? "null"
        columnB = decoder.decodeObject(forKey: "b") as? String ?? "null"
        columnH = decoder.decodeObject(forKey: "h") as? String ?? "null"
        columnI = decoder.decodeObject(forKey: "i") as? String ?? "null"
        columnG = decoder.decodeObject(forKey: "g") as? String ?? "null"
        columnK = decoder.decodeObject(forKey: "k") as? String ?? "null"
        columnN = decoder.decodeObject(forKey: "n") as? String ?? "null"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(columnA, forKey: "a")
        coder.encode(columnB, forKey: "b")
        coder.encode(columnG, forKey: "g")
        coder.encode(columnH, forKey: "h")
        coder.encode(columnI, forKey: "i")
        coder.encode(columnK, forKey: "k")
        coder.encode(columnN, forKey: "n")
    }
}
