//
//  DataManager.swift
//  SecuroVault
//
//  Created by ACoding on 10/8/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit
import MBProgressHUD

class DataManager: NSObject {

    static let sharedManager = DataManager ()
    
    var dbList: [ExcelModel]
    var currentExcel: ExcelModel
    var notification: Bool
    var vibration: Bool
    var timeInterval: Int
    
    override init() {
        dbList = [ExcelModel]()
        currentExcel = ExcelModel()
        notification = true
        vibration = true
        timeInterval = 0
    }
    
    func saveData(){
        let encodedUserData = NSKeyedArchiver.archivedData(withRootObject: dbList)
        UserDefaults.standard.set(encodedUserData, forKey: "excel")
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "excel") {
            dbList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [ExcelModel] ?? [ExcelModel]()
        }else{
            print("Error in loading users data!")
        }
    }
    
    func saveSetting(){
        let encodedUserData1 = NSKeyedArchiver.archivedData(withRootObject: notification)
        let encodedUserData2 = NSKeyedArchiver.archivedData(withRootObject: vibration)
        let encodedUserData3 = NSKeyedArchiver.archivedData(withRootObject: timeInterval)
        
        UserDefaults.standard.set(encodedUserData1, forKey: "notification")
        UserDefaults.standard.set(encodedUserData2, forKey: "vibration")
        UserDefaults.standard.set(encodedUserData3, forKey: "time_interval")
    }
    
    func loadSetting(){
        guard let data1 = UserDefaults.standard.data(forKey: "notification") else {
            print("Error in loading notification")
            return
        }
        guard let data2 = UserDefaults.standard.data(forKey: "vibration") else {
            print("Error in loading notification")
            return
        }
        guard let data3 = UserDefaults.standard.data(forKey: "time_interval") else {
            print("Error in loading notification")
            return
        }
        
        notification = NSKeyedUnarchiver.unarchiveObject(with: data1) as? Bool ?? true
        vibration = NSKeyedUnarchiver.unarchiveObject(with: data2) as? Bool ?? true
        timeInterval = NSKeyedUnarchiver.unarchiveObject(with: data3) as? Int ?? 5

    }
    
    
    func showOKAlert(vc: UIViewController, title: String, message: String, handler: ((UIAlertAction) ->Swift.Void)? = nil ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)

        alertVC.addAction(okAction)
        
        vc.present(alertVC, animated: true, completion: nil)
    }
    
    func searchDB(){
        for dbCount in 0..<15 {
            
            let dbName = "db" + String(dbCount)
            
            let path: String = Bundle.main.path(forResource: dbName, ofType: "xlsx") ?? ""
            
            if path == ""{
            }else{
                let dbModel = ExcelModel()
                dbModel.name = dbName
                dbModel.path = path
                dbList.append(dbModel)
                loadCellToExcelModel(excelData: dbModel)
            }
        }
    }
    
    func loadCellToExcelModel(excelData:ExcelModel){
        let path: String = Bundle.main.path(forResource:excelData.name, ofType: "xlsx")!
        
        let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(path)
        //        let sheet: BRASheet = spreadsheet.workbook.sheets[0] as! BRASheet
        let worksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as! BRAWorksheet
        
        var row = 2
        var tempCell = ""
        var excelRow : ExcelRow?
        let columnList = ["A","B","H","I","G","K","N"]
        
        repeat {
            excelRow = ExcelRow()
            for column in columnList {
                let cell = column + String(row)
                switch (column){
                case "A":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    excelRow?.columnA = data.stringValue()
                case "B":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    excelRow?.columnB = data.stringValue()
                    
                case "H":
//                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    
                    let randomStr = randomFloat()
                    excelRow?.columnH = String(describing: randomStr)
                    
                case "I":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    
                    excelRow?.columnI = data.stringValue()
                    
                case "G":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    excelRow?.columnG = data.stringValue()
                    
                case "K":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    excelRow?.columnK = data.stringValue()
                    
                case "N":
                    let data: BRACell = worksheet.cell(forCellReference: cell)
                    excelRow?.columnN = data.stringValue()
                    
                default:
                    return
                }
            }
            excelData.rows.append(excelRow!)
            row+=1
            tempCell = "A" + String(row)
        } while ((worksheet.cell(forCellReference: tempCell)) != nil)
    }
    
    func randomFloat() -> Float {
        return Float(arc4random()) / Float(UINT32_MAX)
    }
    
    func showProgressBar(view:UIView){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideProgressBar(view:UIView){
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}
