//
//  AppDelegate.swift
//  SLSFlasher
//
//  Created by ACoding on 10/30/17.
//  Copyright © 2017 mobilloper. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var notificationGranted = false
    var notiInterval = 0
    
    func setCategories(){
        let clearRepeatAction = UNNotificationAction(
            identifier: "clear.repeat.action",
            title: "Stop Repeat",
            options: [])
        let category = UNNotificationCategory(
            identifier: "data.reminder.category",
            actions: [clearRepeatAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.tintColor = uicolorFromHex(rgbValue: 0xffffff)
        navBarAppearance.barTintColor = uicolorFromHex(rgbValue: 0x4472C4)
        
        navBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        DataManager.sharedManager.loadData()
        DataManager.sharedManager.loadSetting()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            self.notificationGranted = granted
            if let error = error {
                print("granted, but Error in notification permission:\(error.localizedDescription)")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        setCategories()
        UNUserNotificationCenter.current().cleanRepeatingNotifications()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        if notificationGranted{
            if DataManager.sharedManager.notification{
                repeatNotification()
            }
        }else{
            print("notification not granted")
        }
        
//        let content = UNMutableNotificationContent()
//        content.title = "Data"
//        content.body = "Data1" + ":" + "Data2"
//        content.badge = 1
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5, repeats: true)
//        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
//        })
    }

    func repeatNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "Data!!"
        content.body = "Data A" + ":" + "Data B"
        content.categoryIdentifier = "data.reminder.category"
        content.sound = UNNotificationSound.default()
        
        let  trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
        
        let request = UNNotificationRequest(identifier: "data.reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error in data reminder: \(error.localizedDescription)")
            }
        }
        print("added notification:\(request.identifier)")

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UNUserNotificationCenter.current().cleanRepeatingNotifications()
        print("Did recieve response: \(response.actionIdentifier)")
        if response.actionIdentifier == "clear.repeat.action"{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
        }
        completionHandler()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler(.alert)
//        notiInterval = notiInterval + 1
//        print(notiInterval)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }

}

