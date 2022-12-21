//
//  Shared.swift
//  Sord WatchKit Extension
//
//  Created by Eugenia Esposito on 21/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import Foundation
import UIKit
import Intents

//TableInterface
var importoFloat: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0]
let symbolCurrency = ["€", "$", "£"]

//Interface
var dollari = 0
var spesa: Float = 0

//DetailInterface
var defaults = UserDefaults.standard


let green = UIColor(red: 0.086, green: 0.800, blue: 0.063, alpha: 1.000)


struct DataSource {
    
    let item: Item
    
    enum Item {
        case Dollari(String)
        case Currency(String)
        case Period(String)
        case Unknown
    }
    
    init(data: [String : Any]) {
        if let dollariItem = data["Messaggio"] as? String {
            item = Item.Dollari(dollariItem)
        } else if let currencyItem = data["Currency"] as? String {
            item = Item.Currency(currencyItem)
        } else if let periodItem = data["Period"] as? String {
            item = Item.Period(periodItem)
        } else {
            item = Item.Unknown
        }
    }
}


/*public enum CategoryType: String, Codable {
    case clothing
    case fun
    case health
    case home
    case transport

    public init?(intentWorkoutName: INSpeakableString) {
        switch intentWorkoutName.spokenPhrase.lowercased() {
        case "clothing", "shirt":
            self = .clothing

        case "fun":
            self = .fun

        case "health":
            self = .health
            
        case "home":
            self = .home
            
        case "transport":
            self = .transport

        default:
            return nil
        }
    }

    public var speakableString: INSpeakableString {
        let identifier: String
        let phrase: String
        let hint: String

        switch self {
        case .clothing:
            identifier = "id-categorytype-clothing"
            phrase = "Clothing"
            hint = "clothing"
        case .fun:
            identifier = "id-categorytype-fun"
            phrase = "Fun"
            hint = "fun"
        case .health:
            identifier = "id-categorytype-health"
            phrase = "Health"
            hint = "health"
        case .home:
            identifier = "id-categorytype-home"
            phrase = "Home"
            hint = "home"
        case .transport:
            identifier = "id-categorytype-transport"
            phrase = "Transport"
            hint = "transport"
        }

        if #available(iOS 11.0, *) {
            return INSpeakableString(vocabularyIdentifier: identifier, spokenPhrase: phrase, pronunciationHint: hint)
        }
        else {
            return INSpeakableString(identifier: identifier, spokenPhrase: phrase, pronunciationHint: hint)
        }
    }*/
//}
