//
//  SettingVC.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let scheduleMinute = 12
    let scheduleHour = 22
    
    @IBOutlet weak var swNotification: UISwitch!
    @IBOutlet weak var picTimeInterval: UIPickerView!
    @IBOutlet weak var swVibration: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Setting"
        
        setSetting()
        
        picTimeInterval.selectRow(DataManager.sharedManager.timeInterval, inComponent: 0, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scheduleMinute + scheduleHour
    }
    
    //MARK: PickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row < scheduleMinute - 1 {
            let timeInterval = String((row+1) * 5) + " M"
            return timeInterval
        }else{
            let timeInterval = String(row - scheduleMinute + 2) + " H"
            return timeInterval
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DataManager.sharedManager.timeInterval = row
        DataManager.sharedManager.saveSetting()
    }
    
    //MARK: - CustomFunc
    func setSetting(){
        swNotification.isOn = DataManager.sharedManager.notification
        swVibration.isOn = DataManager.sharedManager.vibration
    }
    
    //MARK: - IBAction
    @IBAction func onAllowNotification(_ sender: Any) {
        if swNotification.isOn {
            DataManager.sharedManager.notification = true
        }else{
            DataManager.sharedManager.notification = false
        }
        DataManager.sharedManager.saveSetting()
    }
    
    @IBAction func onAllowVibration(_ sender: Any) {
        if swVibration.isOn {
            DataManager.sharedManager.vibration = true
        }else{
            DataManager.sharedManager.vibration = false
        }
        DataManager.sharedManager.saveSetting()
    }
    
}
