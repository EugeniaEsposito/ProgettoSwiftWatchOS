//
//  PeriodViewController.swift
//  Sord2
//
//  Created by Eugenia Esposito on 31/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData = ["Daily", "Weekly", "Monthly"]

    @IBOutlet var pickerView: UIPickerView!
    
    @IBAction func saveButton(_ sender: Any) {
        let index = pickerView.selectedRow(inComponent: 0)
        let message = ["Period" : pickerData[index]]
        if WatchSessionManager.sharedManager.validSession != nil {
            WatchSessionManager.sharedManager.transferUserInfo(userInfo: message)
            let alertController = UIAlertController(title: "Success!", message: "Period successfully changed!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            defaults.set(index, forKey: "Row2")
        }
        else {
            let alertController = UIAlertController(title: "Attention!", message: "Failed to change the period. The Watch App isn't installed.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel , handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        let row = defaults.integer(forKey: "Row2")
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
