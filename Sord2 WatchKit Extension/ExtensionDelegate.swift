//
//  ExtensionDelegate.swift
//  Sord2 WatchKit Extension
//
//  Created by Eugenia Esposito on 23/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import WatchKit
import WatchConnectivity
import UserNotifications
import Intents

class ExtensionDelegate: NSObject, WKExtensionDelegate, UNUserNotificationCenterDelegate {
    
    var dateComponents = DateComponents()
    var dateComponents2 = DateComponents()
    
    func applicationDidFinishLaunching() {
        WatchSessionManager.sharedManager.startSession()
        INPreferences.requestSiriAuthorization { status in
          if status == .authorized {
            print("Hey, Siri!")
          } else {
            print("Nay, Siri!")
          }
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            if granted {
                print("Yes!")
                let show = UNNotificationAction(identifier: "show", title: "Yes, add!", options: .foreground)
                let category = UNNotificationCategory(identifier: "id", actions: [show], intentIdentifiers: [], options: [])
                let category2 = UNNotificationCategory(identifier: "id2", actions: [], intentIdentifiers: [], options: [])
                 let category3 = UNNotificationCategory(identifier: "id3", actions: [], intentIdentifiers: [], options: [])
                
                center.setNotificationCategories([category, category2, category3])
                center.removeAllPendingNotificationRequests()
                
                self.firstNotification()
                self.secondNotification()
                print("notification scheduled")
            } else {
                print("Nope!")
            }
        }
    }
    
    func firstNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        dateComponents.hour = 19
                dateComponents.minute = 00
                
                let content = UNMutableNotificationContent()
                content.title = "Day's Expense"
                content.body = "Did you spend anything today?"
                content.categoryIdentifier = "id"
                content.sound = UNNotificationSound.default
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
    }
    
    func secondNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        dateComponents2.hour = 08
        dateComponents2.minute = 00
                
        let content2 = UNMutableNotificationContent()
        content2.title = "Good Morning"
        content2.body = "Remember your limit and don't exceed it."
        content2.categoryIdentifier = "id2"
        content2.sound = UNNotificationSound.default
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: true)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content2, trigger: trigger2)
        center.add(request2)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                TableInterfaceController.shared.loadTableData()
                intentDidRunTask.setTaskCompletedWithSnapshot(true)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
