//
//  UserModel.swift
//  SecuroVault
//
//  Created by ACoding on 10/8/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class ExcelModel: NSObject, NSCoding {

    var name: String?
    var path: String?
    var rows: [ExcelRow]

    override init() {
        name = ""
        path = ""
        rows = [ExcelRow]()
    }
    
    required init(coder decoder: NSCoder){
        name = decoder.decodeObject(forKey: "name") as? String ?? "null"
        path = decoder.decodeObject(forKey: "path") as? String ?? "null"
        rows = decoder.decodeObject(forKey: "rows") as? [ExcelRow] ?? [ExcelRow]()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(path, forKey: "path")
        coder.encode(rows, forKey: "rows")
    }
    
}
