//
//  ViewController2.swift
//  Sord2
//
//  Created by Eugenia Esposito on 25/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit
import WatchConnectivity


class LimitViewController: UIViewController, DataSourceChangedDelegate {
    
    func dataSourceDidUpdate(dataSource: DataSource) {
        switch dataSource.item {
        case .Dollari(let dollariItem):
            oldLimit.text = dollariItem
            defaults.set(dollariItem, forKey: "Value")
        case .Currency(_):
            return
        case .Period(_):
            return
        case .Unknown:
            return
        }
    }
    
    
//    var root = UITableViewController() as? TableViewController
    var session: WCSession!

    @IBOutlet var oldLimit: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        let message = ["Messaggio" : textField.text]
        if WatchSessionManager.sharedManager.validSession != nil {
            WatchSessionManager.sharedManager.transferUserInfo(userInfo: message)
            WatchSessionManager.sharedManager.transferCurrentComplicationUserInfo(userInfo: message)
            oldLimit.text = textField.text
            defaults.set(textField.text, forKey: "Value")
            let alertController = UIAlertController(title: "Success!", message: "Limit successfully changed!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
//        if WatchSessionManager.sharedManager.validSession != nil {
//            do {
//                try WatchSessionManager.sharedManager.updateApplicationContext(applicationContext: ["Messaggio" : textField.text])
//                oldLimit.text = textField.text
//                defaults.set(textField.text, forKey: "Value")
//                let alertController = UIAlertController(title: "Success!", message: "Limit successfully changed!", preferredStyle: UIAlertController.Style.alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                present(alertController, animated: true, completion: nil)
//            } catch {
//                print("error")
//            }
//        }
        else {
            let alertController = UIAlertController(title: "Attention!", message: "Failed to change the limit. The Watch App isn't installed.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel , handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        WatchSessionManager.sharedManager.addDataSourceChangedDelegate(delegate: self)
        super.viewDidLoad()
//        if (WCSession.isSupported()) {
//            session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
        let value = defaults.integer(forKey: "Value")
        if value == 0 {
            oldLimit.text = ""
        } else {
            oldLimit.text = "\(value)"
        }
    }

}

//extension LimitViewController: WCSessionDelegate {
//
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        let value = applicationContext["Messaggio"] as? Int
//        DispatchQueue.main.async {
//            if let value = value {
////                self.oldLimit.text = "\(value)"
////                defaults.set(value, forKey: "Value")
//            }
//        }
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        if let error = error {
//            print("WC Session activation failed with error: \(error.localizedDescription)")
//            return
//        }
//        print("WC Session activated with state: \(activationState.rawValue)")
//    }
//
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        print("WC Session did become inactive")
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        print("WC Session did deactivate")
//        WCSession.default.activate()
//    }
//
//}
