//
//  TableInterfaceController.swift
//  Sord WatchKit Extension
//
//  Created by Eugenia Esposito on 21/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import WatchKit
import Foundation
import Intents

class TableInterfaceController: WKInterfaceController, DataSourceChangedDelegate {
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
        case .Period(_):
            return
        case .Unknown:
            return
        }
    }
    let amount = defaults.float(forKey: "amountSiri")
    let expense = defaults.float(forKey: "Expense")
    static let shared = TableInterfaceController()

    let data = ["Clothing", "Fun", "Health", "Home", "Transport"]
    
    let img = ["shirt-3", "popcorn", "medication-3", "house-3", "train-3"]
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    func loadTableData() {
        let currency = defaults.string(forKey: "Symbol")
        tableView.setNumberOfRows(data.count, withRowType: "RowController")
        for (i, dataName) in data.enumerated() {
            let row = tableView.rowController(at: i) as! RowController
            row.label.setText(dataName)
            if currency != nil {
                row.myLabel.setText("\((importoFloat[i])+amount) \(currency!)")
            } else {
                row.myLabel.setText("\(importoFloat[i]) $")
            }
            row.image.setImageNamed(img[i])
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return rowIndex
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.setTitle("Category")
        
        // Configure interface objects here.
    }

    override func willActivate() {
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        super.willActivate()
        loadTableData()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
