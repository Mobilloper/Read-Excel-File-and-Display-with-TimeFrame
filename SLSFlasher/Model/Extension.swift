//
//  extension.swift
//  SmileLock-Example
//
//  Created by yuchen liu on 4/24/16.
//  Copyright © 2016 Recruit Lifestyle Co., Ltd. All rights reserved.
//

import UIKit
import UserNotifications

extension UNUserNotificationCenter{
    func cleanRepeatingNotifications(){
        //cleans notification with a userinfo key endDate
        //which have expired.
        var cleanStatus = "Cleaning...."
        getPendingNotificationRequests {
            (requests) in
            for request in requests{
                if let endDate = request.content.userInfo["endDate"]{
                    if Date() >= (endDate as! Date){
                        cleanStatus += "Cleaned request"
                        let center = UNUserNotificationCenter.current()
                        center.removePendingNotificationRequests(withIdentifiers: [request.identifier])
                    } else {
                        cleanStatus += "No Cleaning"
                    }
                    print(cleanStatus)
                }
            }
        }
    }
}


extension String {
    static func random(length: Int = 6 ) ->String {
//        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return "SECURE\(randomString)"
    }
    
    func  toDate() -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss.A"
        
        var dateArray = self.components(separatedBy: "/")
        let temp = "20" + dateArray[2] + "/" + dateArray[0]+"/"+dateArray[1]+" 05:30:32.0"
        
        if let date = dateFormatter.date(from: temp)
        {
            return date
        }
        print("Invalid arguments ! Returning Current Date . ")
        return Date()
    }
}

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}

