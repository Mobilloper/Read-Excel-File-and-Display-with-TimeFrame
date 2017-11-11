//
//  PlayVC.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit
import AudioToolbox

class PlayVC: UIViewController {

    //MARK: - Properties
    var selectedIndex = 0
    var excelData = ExcelModel()
    var excelRow = ExcelRow()
    var excelCell = ""
    var tempCell = ""
    var playSpeed = 0
    
    let columnList = ["A","B","H","I","G","K","N"]
    var timer = Timer()
    
    var row = 2
    var backgroundColours = [UIColor()]
    var displayLoop = 0
    var pauseLoop = 0
    var isPause = false
    
    var sortedArray = [ExcelRow]()
    
//    var HUD : MBProgressHUD = MBProgressHUD()
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblDataLeft: UILabel!
    @IBOutlet weak var lblDataRight: UILabel!
    
    @IBOutlet weak var vBackground: UIView!
    
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Play"
        
        excelData = DataManager.sharedManager.dbList[selectedIndex]
        getSortedArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    //MARK: - CustomFunc
    
    func getSortedArray(){
        sortExcelModelByColumnHAsAscending(excelData: excelData)
        sortExcelModelByDay()
    }
    
    func sortExcelModelByColumnHAsAscending(excelData:ExcelModel){
        excelData.rows.sort {
            $0.columnH! < $1.columnH!
        }
    }
    func sortExcelModelByDay(){
        let day = getDayOfCurrentWeek()
        sortedArray = excelData.rows.filter() {
            $0.columnK == String(day)
        }
    }
    
    func getDayOfCurrentWeek()->Int{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.string(from: Date())
        
        switch dayOfWeekString {
        case "Monday":
            return 1
        case "Tuesday":
            return 2
        case "Wednesday":
            return 3
        case "Thursday":
            return 4
        case "Friday":
            return 5
        case "Saturday":
            return 6
        case "Sunday":
            return 7
        default:
            return 1
        }
    }
    
    @objc func changeLabelWithSortedData(){
        self.lblDataLeft.text = self.sortedArray[row].columnA
        self.lblDataRight.text = self.sortedArray[row].columnB
    }
    
   
    func displayWith(_ interval: Int) {
        
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: false, block: { (Timer) in
            
            if self.displayLoop == self.sortedArray.count - 1{
                
                self.timer.invalidate()
                self.btnPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                self.displayLoop = 0
                self.pauseLoop = 0
                self.playSpeed = 0
                
                self.isPause = false
                
                //set Random value to columnH and sort ascending
                self.resetColumnH()
                //decrease columnN
                self.decreaseColumnN()
                self.getSortedArray()
                
                self.sliderTime.isEnabled = true
                
                return
            }else {
                
                
                self.lblDataLeft.text = self.sortedArray[self.displayLoop].columnA
                self.lblDataRight.text = self.sortedArray[self.displayLoop].columnB
                
                let date = self.sortedArray[self.displayLoop].columnI?.toDate()
                let currentDate = Date()
                
                let diff = currentDate.interval(ofComponent: .day, fromDate: date!)
                
                if diff < 90 {
                    self.lblDataLeft.textColor = UIColor.red
                    self.lblDataRight.textColor = UIColor.red
                }else if diff > 180 {
                    self.lblDataLeft.textColor = UIColor.green
                    self.lblDataRight.textColor = UIColor.green
                }else{
                    self.lblDataLeft.textColor = UIColor.blue
                    self.lblDataRight.textColor = UIColor.blue
                }
                
                if self.sortedArray[self.displayLoop].columnN != "0" {
                    if DataManager.sharedManager.vibration{
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                    self.vBackground.backgroundColor = UIColor.yellow
                }else{
                    self.vBackground.backgroundColor = UIColor.white
                }
                
                self.displayLoop+=1

                let stringCount = Float((self.sortedArray[self.displayLoop].columnB?.count)! + (self.sortedArray[self.displayLoop].columnA?.count)!)
                self.playSpeed = Int(stringCount / self.sliderTime.value)
                
                self.displayWith(self.playSpeed)
            }
        })
    }
    
    func resetColumnH(){
        for count in 0..<excelData.rows.count {
            let randomStr = DataManager.sharedManager.randomFloat()
            excelData.rows[count].columnH = String(describing: randomStr)
        }
    }
    
    func decreaseColumnN(){
        for count in 0..<excelData.rows.count {
            var tempN = Int(excelData.rows[count].columnN!)

            if tempN! > 0{
                tempN = tempN! - 1
                excelData.rows[count].columnN = String(tempN!)
            }else{
            }
        }
    }
    
    //MARK: - IBOutlets
    @IBAction func onBtnPlay(_ sender: Any) {
        
        if sortedArray.count > 0 {
            if !isPause {
                if pauseLoop == 0 {
                    let stringCount = Float((sortedArray[0].columnB?.count)! + (sortedArray[0].columnA?.count)!)
                    playSpeed = Int(stringCount / sliderTime.value)
                    displayWith(playSpeed)
                }else{
//                    displayLoop = pauseLoop
                    let stringCount = Float((sortedArray[displayLoop].columnB?.count)! + (sortedArray[displayLoop].columnA?.count)!)
                    playSpeed = Int(stringCount / sliderTime.value)
                    displayWith(playSpeed)
                }
                btnPlay.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
                isPause = true
//                sliderTime.isEnabled = false
                pauseLoop = 0
            }else{
                self.timer.invalidate()
//                sliderTime.isEnabled = true
                btnPlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                pauseLoop = displayLoop
                playSpeed = 0

                isPause = false
            }
        }else {
            lblDataLeft.text = "There is "
            lblDataRight.text = "no Data"
        }
        
    }

    @IBAction func onSliderTime(_ sender: Any) {
     print(sliderTime.value)
    }
    
}
