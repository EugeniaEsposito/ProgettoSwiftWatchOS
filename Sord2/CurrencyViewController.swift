//
//  CurrencyViewController.swift
//  Sord2
//
//  Created by Eugenia Esposito on 30/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var pickerView: UIPickerView!
    
    var pickerData = ["Euro", "Dollars", "Pounds"]
    
    @IBAction func saveButton(_ sender: Any) {
        let index = pickerView.selectedRow(inComponent: 0)
        let message = ["Currency" : pickerData[index]]
        if WatchSessionManager.sharedManager.validSession != nil {
            WatchSessionManager.sharedManager.transferUserInfo(userInfo: message)
            let alertController = UIAlertController(title: "Success!", message: "Currency successfully changed!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            defaults.set(index, forKey: "Row")
        }
        else {
            let alertController = UIAlertController(title: "Attention!", message: "Failed to change the currency. The Watch App isn't installed.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel , handler: nil))
            present(alertController, animated: true, completion: nil)
        }
//        do {
//            try WatchSessionManager.sharedManager.updateApplicationContext(applicationContext: messagge)
//        }
//        catch {
//            print("error")
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        let row = defaults.integer(forKey: "Row")
        pickerView.selectRow(row, inComponent: 0, animated: false)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

}
