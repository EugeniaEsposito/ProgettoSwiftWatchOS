//
//  DetailInterfaceController.swift
//  Sord WatchKit Extension
//
//  Created by Eugenia Esposito on 21/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import UserNotifications

class DetailInterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {
    
    var number = String()
    var usedDecimal = false
    var index = 0
    var check = false
    var check2 = defaults.bool(forKey: "Check")
    
    @IBOutlet var resultLabel: WKInterfaceLabel!
    
    @IBAction func zero() {
        if number == "0." {
            addToDisplay("0")
        }
        else if number != "0" {
            addToDisplay("0")
        }
    }
    
    @IBAction func one() {
        addToDisplay("1")
    }
    
    @IBAction func two() {
        addToDisplay("2")
    }
    
    @IBAction func three() {
        addToDisplay("3")
    }
    
    @IBAction func four() {
        addToDisplay("4")
    }
    
    @IBAction func five() {
        addToDisplay("5")
    }
    
    @IBAction func six() {
        addToDisplay("6")
    }
    
    @IBAction func seven() {
        addToDisplay("7")
    }
    
    @IBAction func eight() {
        addToDisplay("8")
    }
    
    @IBAction func nine() {
        addToDisplay("9")
    }
  
    @IBAction func decimal() {
        if !usedDecimal {
            if number == "0" {
                addToDisplay(".")
                usedDecimal = true
            }
            else if !number.isEmpty{
                addToDisplay(".")
                usedDecimal = true
            }
        }
    }
    
    @IBOutlet var deleteButton: WKInterfaceButton!
    
    @IBAction func delete() {
        number.removeLast()
        resultLabel.setText(number)
        if number.last == "." {
            usedDecimal = false
        }
        if number.isEmpty {
            addToDisplay("0")
        }
    }

    @IBAction func clear() {
        number.removeAll()
        usedDecimal = false
        addToDisplay("0")
    }
    
    @IBAction func add() {
        defaults.set(number, forKey: "Spesa")
        let spesacorr = defaults.float(forKey: "Spesa")
        spesa += spesacorr
        importoFloat[index] += spesacorr
        if Int(spesa) >= 75*dollari/100 && check == false && check2 == false {
            check = true
            defaults.set(check, forKey: "Check")
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            let content3 = UNMutableNotificationContent()
            content3.title = "Alert"
            content3.body = "You're almost broke."
            content3.categoryIdentifier = "id3"
            content3.sound = UNNotificationSound.default
            let trigger3 = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request3 = UNNotificationRequest(identifier: UUID().uuidString, content: content3, trigger: trigger3)
            center.add(request3)
        }
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimeline(for: complication)
        }
        pop()
    }
    
    func addToDisplay(_ s: Character) {
        
        if number == "0" && s != "." {
            number.remove(at: number.startIndex)
        }
        if (number.count == 14) { }
        else {
            number.append(s)
        }
        resultLabel.setText(number)
        changeDeleteButton()
    }
    
    func changeDeleteButton() {
        if number != "0" {
            deleteButton.setEnabled(true)
            deleteButton.setHidden(false)
        }
        else {
            deleteButton.setEnabled(false)
            deleteButton.setHidden(true)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        index = context as? Int ?? 0
        self.setTitle("Back")
        addToDisplay("0")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
