//
//  HomeVC.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let mainList = ["Select database", "Play", "Statistics", "Setting", "Upload"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == mainList[0]{
            let vc = segue.destination as! SelectDatabaseVC
            vc.navigationController?.title = mainList[0]
        } else if segue.identifier == mainList[1]{
            let vc = segue.destination as! SelectDatabaseVC
            vc.navigationController?.title = mainList[1]
        }else if segue.identifier == mainList[2]{
            let vc = segue.destination as! SelectDatabaseVC
            vc.navigationController?.title = mainList[2]
        }else if segue.identifier == mainList[3]{
            let vc = segue.destination as! SelectDatabaseVC
            vc.navigationController?.title = mainList[3]
        }else if segue.identifier == mainList[4]{
            let vc = segue.destination as! SelectDatabaseVC
            vc.navigationController?.title = mainList[4]

        }
    }

}
