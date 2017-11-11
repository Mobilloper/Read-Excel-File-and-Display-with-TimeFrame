//
//  SelectDatabaseTVCell.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class SelectDatabaseTVCell: UITableViewCell{
    
    //MARK: -IBOutlets
    @IBOutlet weak var lblDatabaseName: UILabel!
    
    @IBOutlet weak var lblDBName: UILabel!
    @IBOutlet weak var lblDBPath: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
