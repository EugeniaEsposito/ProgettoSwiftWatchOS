//
//  CalendarViewController.swift
//  Sord2
//
//  Created by Eugenia Esposito on 27/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import UIKit

//enum MyTheme {
//    case light
//    case dark
//}

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        if traitCollection.userInterfaceStyle == .dark {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: green]
            Style.themeDark()
            
        } else {
            Style.themeLight()
        }
        super.viewDidLoad()
                self.navigationController?.navigationBar.isTranslucent=false
//                self.view.backgroundColor=Style.bgColor
                
                view.addSubview(calenderView)
                calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive=true
                calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
                calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
                calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
            }
            
            override func viewWillLayoutSubviews() {
                super.viewWillLayoutSubviews()
                calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
            }
            
            
            let calenderView: CalenderView = {
                let v=CalenderView()
                v.translatesAutoresizingMaskIntoConstraints=false
                return v
            }()
            
        }

