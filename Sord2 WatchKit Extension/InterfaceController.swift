//
//  InterfaceController.swift
//  Sord2 WatchKit Extension
//
//  Created by Eugenia Esposito on 23/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import WatchKit
import Foundation



var firstDollar = 50

class InterfaceController: WKInterfaceController, DataSourceChangedDelegate {
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        switch dataSource.item {
        case .Dollari(_):
            return
        case .Currency(let currencyItem):
            if currencyItem == "Euro" {
                defaults.set(symbolCurrency[0], forKey: "Symbol")
            } else if currencyItem == "Dollars" {
                defaults.set(symbolCurrency[1], forKey: "Symbol")
            } else if currencyItem == "Pounds" {
                defaults.set(symbolCurrency[2], forKey: "Symbol")
            }
        case .Period(let periodItem):
            defaults.set(periodItem, forKey: "Period")
        default:
            return
        }
    }

    let format = DateFormatter()
    var lastDay: String?
    var lastWeek: String?
    var lastMonth: String?
    
    @IBOutlet var statsImg: WKInterfaceImage!
    
    @IBOutlet var label: WKInterfaceLabel!
    
    @IBAction func onImpostaLimite() {
        self.presentController(withName: "Limite", context: dollari)
    }
    
    
    func createRing() {
        let currency = defaults.string(forKey: "Symbol")
        UIGraphicsBeginImageContext(CGSize(width: 156, height: 195))
        let image = WatchStatsDrawer.drawActivityCompositionGreen(wellnessLevel: 0, frame: CGRect(x: 0, y: 0, width: 156, height: 195), resizing: WatchStatsDrawer.ResizingBehavior.aspectFit)
        statsImg.setImage(image)
        if currency != nil {
            label.setText("0 \(currency!)")
        } else {
            label.setText("0 $")
        }
        UIGraphicsEndImageContext()
    }
    
    func updateRing(dollars: Int) {
        let currency = defaults.string(forKey: "Symbol")
            if spesa <= Float(dollars) {
                let dollariF = Float(dollars)
                let percent = spesa/dollariF
                let percentCGF = CGFloat(percent)
                UIGraphicsBeginImageContext(CGSize(width: 156, height: 195))
                let image = WatchStatsDrawer.drawActivityCompositionGreen(wellnessLevel: percentCGF, frame: CGRect(x: 0, y: 0, width: 156, height: 195), resizing: WatchStatsDrawer.ResizingBehavior.aspectFit)
                statsImg.setImage(image)
                UIGraphicsEndImageContext()
            }
            else {
                if spesa <= Float(dollars * 3) {
                    let dollariF = Float(dollars * 2)
                    let overSpesa = spesa - Float(dollars)
                    let percent = overSpesa/dollariF
                    let percentCGF = CGFloat(percent)
                    UIGraphicsBeginImageContext(CGSize(width: 156, height: 195))
                    let image = WatchStatsDrawer.drawActivityCompositionRed(wellnessLevel: percentCGF, frame: CGRect(x: 0, y: 0, width: 156, height: 195), resizing: WatchStatsDrawer.ResizingBehavior.aspectFit)
                    statsImg.setImage(image)
                    UIGraphicsEndImageContext()
                }
                else if spesa <= Float(dollars * 7) { //limite totale
                    let dollariF = Float(dollars * 4) //limite del nuovo anello
                    let overSpesa = spesa - Float(dollars * 3) //togliere il valore degli anelli precedenti
                    let percent = overSpesa/dollariF
                    let percentCGF = CGFloat(percent)
                    UIGraphicsBeginImageContext(CGSize(width: 156, height: 195))
                    let image = WatchStatsDrawer.drawActivityCompositionRed2(wellnessLevel: percentCGF, frame: CGRect(x: 0, y: 0, width: 156, height: 195), resizing: WatchStatsDrawer.ResizingBehavior.aspectFit)
                    statsImg.setImage(image)
                    UIGraphicsEndImageContext()
                }
                else if spesa <= Float(dollars * 2000) {
                    let dollariF = Float(dollars * 6)
                    let overSpesa = spesa - Float(dollars * 7)
                    let percent = overSpesa/dollariF
                    let percentCGF = CGFloat(percent)
                    UIGraphicsBeginImageContext(CGSize(width: 156, height: 195))
                    let image = WatchStatsDrawer.drawActivityCompositionRed3(wellnessLevel: percentCGF, frame: CGRect(x: 0, y: 0, width: 156, height: 195), resizing: WatchStatsDrawer.ResizingBehavior.aspectFit)
                    statsImg.setImage(image)
                    UIGraphicsEndImageContext()
                }
            }
        if currency != nil {
            label.setText("\(spesa) \(currency!)")
        } else {
            label.setText("\(spesa) $")
        }
    }
    
    override func awake(withContext context: Any?) {
//        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        super.awake(withContext: context)
        self.setTitle("SaveTheMoney")
//        createRing()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        super.willActivate()
        format.dateStyle = .short
        if spesa == 0 {
            createRing()
        }
        if (dollari != 0 && spesa != 0){
            updateRing(dollars: dollari)
        }
        else if (firstDollar != 0 && spesa != 0) {
            updateRing(dollars: firstDollar)
        }
        let period = defaults.string(forKey: "Period")
        if period == "Daily" || period == nil {
            if lastDay == nil && firstDollar != 0 {
                defaults.set("", forKey: "Data")
                lastDay = defaults.string(forKey: "Data")
                let today = format.string(from: Date())
                if lastDay! < today {
                    resetExpense(limit: firstDollar)
                    defaults.set(today, forKey: "Data")
                    lastDay = defaults.string(forKey: "Data")
                }
            }
            else if lastDay != "" && firstDollar == 0 {
                let today = format.string(from: Date())
                if lastDay! < today {
                    resetExpense(limit: dollari)
                    resetComplication()
                    defaults.set(today, forKey: "Data")
                    lastDay = defaults.string(forKey: "Data")
                }
            }
        }
//            else if period == "Weekly" {
//            format.dateFormat = "EEEE"
//            var calendar = Calendar.current
//            calendar.firstWeekday = 2
//            let firstWeekDay = calendar.firstWeekday
//            if lastWeek == nil && firstDollar != 0 {
//                defaults.set("", forKey: "Week")
//                lastWeek = defaults.string(forKey: "Week")
//                var today = calendar.component(.weekday, from: Date())
//                if lastWeek == firstWeekDay {
//
//                }
//            }
//        } else if period == "Monthly" {
//
//        }
        
//        format.dateFormat = "hh:mm"
//        let today = format.string(from: Date())
//        if today == "12:23" {
//            spesa = 0
//            updateRing(dollars: dollari)
//            for (i, value) in importoFloat.enumerated() {
//                importoFloat[i] = 0.0
//            }
//        }
    }
    
    func resetExpense(limit: Int) {
        let currency = defaults.string(forKey: "Symbol")
        spesa = 0
        updateRing(dollars: limit)
        if currency != nil {
            label.setText("0 \(currency!)")
        } else {
            label.setText("0 $")
        }
        for (i, value) in importoFloat.enumerated() {
            importoFloat[i] = 0.0
        }
    }
    
    func resetComplication() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in (server.activeComplications)! {
            server.reloadTimeline(for: complication)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
