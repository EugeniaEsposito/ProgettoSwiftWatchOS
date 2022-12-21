//
//  StatisticsViewController.swift
//  Sord2
//
//  Created by Eugenia Esposito on 27/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        if traitCollection.userInterfaceStyle == .dark {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: green]
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
