//
//  SelectDatabaseVC.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class SelectDatabaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //MARK: -Properties
    var dataCount = ["Database1", "Database2", "Database3", "Database4"]
    var selectedIndex = 0
    
    //MARK: -IBOutlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select database"
        // Do any additional setup after loading the view.
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
        if DataManager.sharedManager.dbList.count == 0 {
            DataManager.sharedManager.showOKAlert(vc: self, title: "Alert", message: "There is no database to choose. Upload Excel files, please.", handler: {(okAction) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
        }
        return DataManager.sharedManager.dbList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SelectDatabaseTVCell!
        cell?.selectionStyle = .none
        
        cell?.lblDatabaseName.text = DataManager.sharedManager.dbList[indexPath.row].name
        
        return cell!
    }
    
    //MARK: - TableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "play", sender: nil)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "play"{
            let vc = segue.destination as! PlayVC
            vc.selectedIndex = selectedIndex
        }
        
    }
}
