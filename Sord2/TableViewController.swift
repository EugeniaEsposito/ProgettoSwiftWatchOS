//
//  TableViewController.swift
//  Sord2
//
//  Created by Eugenia Esposito on 25/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit
import WatchConnectivity


class TableViewController: UITableViewController {
    
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var switchButton: UISwitch!
    var mode: Int!
    
    func makeDark() {
//        overrideUserInterfaceStyle = .dark
//        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: green]
//        tabBarController?.tabBar.barStyle = .black
    }
    
    func makeLight() {
//        overrideUserInterfaceStyle = .light
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        tabBarController?.tabBar.barStyle = .default
    }
    
    func checkMode() {
        if traitCollection.userInterfaceStyle == .dark {
            makeDark()
        }
//        if defaults.integer(forKey: "Switch") == 1 {
//            makeDark()
//            switchButton.isOn = true
//        }
//        else {
//            makeLight()
//            switchButton.isOn = false
//        }
    }
    
    var session: WCSession!
    override func viewDidLoad() {
        checkMode()
        super.viewDidLoad()
//        if (WCSession.isSupported()) {
//            session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
    }
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return settings.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//    }
        
        // Configure the cell...

        
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

//extension TableViewController: WCSessionDelegate {
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        let value = applicationContext["Messaggio"] as? Int
//        DispatchQueue.main.async {
//            if let value = value {
////                self.oldLimit.text = "\(value)"
//                defaults.set(value, forKey: "Value")
//            }
//        }
//    }
//
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        print("session inactive")
//    }
//
//    func sessionDidDeactivate(_ session: WCSession) {
//        print("session deactivate")
//        WCSession.default.activate()
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        print("watchOS: \(#function)")
//    }
//
//
//}
