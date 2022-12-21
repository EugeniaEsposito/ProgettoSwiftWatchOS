//
//  LimiteInterfaceController.swift
//  Sord
//
//  Created by Eugenia Esposito on 21/01/2020.
//  Copyright © 2019 iOS Foundation. All rights reserved.
//

import WatchKit
import Foundation
//import WatchConnectivity

class LimiteInterfaceController: WKInterfaceController, WKCrownDelegate, DataSourceChangedDelegate {
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        switch dataSource.item {
        case .Dollari(let dollariItem):
            label.setText(dollariItem)
            defaults.set(Int(dollariItem), forKey: "Limite")
        case .Currency(let currencyItem):
            currencyLabel.setText(currencyItem.uppercased())
            defaults.set(currencyItem.uppercased(), forKey: "Currency")
        case .Period(_):
            return
        case .Unknown:
            return
        }
    }
    
    
    var crownAccumulator = 0.0
    var dollarBool = false
    var dollars = 0
    var dollar = 0
//    var session: WCSession!
    
    @IBOutlet var label: WKInterfaceLabel!
    
    @IBOutlet var currencyLabel: WKInterfaceLabel!
    
    @IBAction func onMinusButton() {
        minus()
        if (dollari < 0 || dollars < 0) {
            dollars = 0
        }
        updateConfiguration()
    }
    
    @IBAction func onPlusButton() {
        plus()
        updateConfiguration()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        crownAccumulator += rotationalDelta
        if crownAccumulator > 0.1 {
            plus()
            crownAccumulator = 0.0
            updateConfiguration()
        }
        else if crownAccumulator < -0.1 {
            minus()
            crownAccumulator = 0.0
            updateConfiguration()
        }
        if (dollari < 0 || dollars < 0) {
            dollars = 0
            updateConfiguration()
        }
    }
    
    func minus() {
        if dollari == 0 && firstDollar != 0 {
            dollars = firstDollar
            dollars -= 10
            firstDollar = 0
        }
        else {
            dollars -= 10
        }
        if (dollari != 0 && dollar == 0) {
            if !dollarBool {
                dollar = dollari
                dollar -= 10
                dollarBool = true
            }
            else {
                dollar = 0
            }
        }
        else {
            dollar -= 10
        }
    }
    
    func plus() {
        if dollari == 0 && firstDollar != 0 {
            dollars = firstDollar
            dollars += 10
            firstDollar = 0
        }
        else {
            dollars += 10
        }
        if (dollari != 0 && dollar == 0) {
            if !dollarBool {
                dollar = dollari
                dollar += 10
                dollarBool = true
            }
            else {
                dollar += 10
            }
        }
        else {
            dollar += 10
        }
    }
    
    @IBAction func onImpostaButton() {
        if dollari == 0 {
            dollari = dollars
            defaults.set(dollari, forKey: "Limite")
        }
        else {
            dollari = dollar
            defaults.set(dollari, forKey: "Limite")
        }
//        let message = ["Messaggio" : dollari as Int]
        WatchSessionManager.sharedManager.transferUserInfo(userInfo: ["Messaggio" : String(dollari)])
//        do {
//            try WatchSessionManager.sharedManager.updateApplicationContext(applicationContext: ["Messaggio" : String(dollari)])
//            print("messaggio inviato")
//        }
//        catch {
//            print("error")
//        }
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimeline(for: complication)
        }
        dismiss()

    }
    
    func updateConfiguration() {
        if dollari == 0 {
            label.setText("\(dollars)")
        }
        else {
            label.setText("\(dollar)")
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.delegate = self
        crownSequencer.focus()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        super.willActivate()
        let currency = defaults.string(forKey: "Currency")
        if currency == nil {
            currencyLabel.setText("DOLLARS")
        }
        else {
            currencyLabel.setText(currency)
        }
        if (dollari != 0 || defaults.string(forKey: "Limite") != nil) {
            dollari = defaults.integer(forKey: "Limite")
            label.setText("\(dollari)")
        }
        else {
            firstDollar = 50
            label.setText("\(firstDollar)")
        }
//        if WCSession.isSupported() {
//            session = WCSession.default
//            session.delegate = self
//            session.activate()
//        } else { print("WCSession non e' supportato dal dispositivo in uso") }
//
//        if WCSession.default.isReachable {
//            print("Siamo Connessi, possiamo inviare dati")
//        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
//        WatchSessionManager.sharedManager.removeDataSourceChangedDelegate(delegate: self)
        super.didDeactivate()
    }

}
