//
//  UploadVC.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit
import MBProgressHUD

class UploadVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    //MARK: -Properties
    var dbList = [ExcelModel]()
    var button = UIButton()
    var isEdit = false

    //MARK: -IBOutlets
    @IBOutlet weak var tvDbList: UITableView!
    @IBOutlet weak var barBtnPencil: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        button = UIButton (type: .system)
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.sizeToFit()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (customView: button)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        button.addTarget(self, action: #selector(self.changeBarButtonImage), for: .touchUpInside)

        if DataManager.sharedManager.dbList.count == 0 {
            DataManager.sharedManager.searchDB()
            DataManager.sharedManager.saveData()
            DataManager.sharedManager.showOKAlert(vc: self, title: "Welcome", message: "Excel files were uploaded! You can select database.")
        }else if DataManager.sharedManager.dbList.count > 0 {
        }else {
            DataManager.sharedManager.showOKAlert(vc: self, title: "Alert", message: "There is no any Excel file in your phone. Store Excel file to paly data, please.", handler: {(okAction) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataManager.sharedManager.dbList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "dblistcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SelectDatabaseTVCell!
        cell?.selectionStyle = .none
        
        cell?.lblDBName?.text = DataManager.sharedManager.dbList[indexPath.row].name
        cell?.lblDBPath?.text = DataManager.sharedManager.dbList[indexPath.row].path
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataManager.sharedManager.dbList.remove(at: indexPath.row)
            DataManager.sharedManager.saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if isEdit {
            return true
        }else {
            return false
        }
    }
    
    
    //MARK: - CustomFunc
    @objc func changeBarButtonImage () {
        
        if isEdit {
            button.setImage(UIImage(named: "pencil"), for: .normal)
        }else{
            button.setImage(UIImage(named: "checkmark"), for: .normal)
        }
        isEdit = !isEdit
        tvDbList.reloadData()
    }
}
