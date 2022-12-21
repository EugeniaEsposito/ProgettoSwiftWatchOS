//
//  AggiungiSpesaIntentHandler.swift
//  Sord2
//
//  Created by Eugenia Esposito on 25/01/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import Foundation
import Intents

class AddExpenseIntentHandler: NSObject, AddExpenseIntentHandling {
    
    func handle(intent: AddExpenseIntent, completion: @escaping (AddExpenseIntentResponse) -> Void) {
        let amount = intent.amount as! Float
        let category = intent.category
        if category == .clothing {
            importoFloat[0] = amount
            defaults.set(importoFloat[0], forKey: "amountSiri")
            spesa += amount
            defaults.set(spesa, forKey: "Expense")
        }
//        let intent = IntentManager.shared.intent(withAmount: intent.amount ?? 0, withCategory: intent.category)
//        IntentManager.shared.donateShortcuts(withIntent: intent)
//        guard let intent = intent else {
//            completion(AddExpenseIntentResponse.init(code: .failure, userActivity: nil))
//            return
//        }
        completion(AddExpenseIntentResponse.init(code: .success, userActivity: nil))
    }
    
    func resolveAmount(for intent: AddExpenseIntent, with completion: @escaping (AddExpenseAmountResolutionResult) -> Void) {
        guard let amount = intent.amount else {
            completion(AddExpenseAmountResolutionResult.needsValue())
            return
        }
        completion(AddExpenseAmountResolutionResult.confirmationRequired(with: amount as? Double))
//        completion(AddExpenseAmountResolutionResult.success(with: amount as? Double ?? 0))
    }
    
    func resolveCategory(for intent: AddExpenseIntent, with completion: @escaping (CategoryTypeResolutionResult) -> Void) {
        if intent.category == .unknown {
            completion(CategoryTypeResolutionResult.needsValue())
        } else {
            completion(CategoryTypeResolutionResult.success(with: intent.category))
        }
    }
    
    
//    func handle(intent: AddExpenseIntent, completion: @escaping (AddExpenseIntentResponse) -> Void) {
////            if intent.category == "Clothing"{
////                importoFloat[0] = intent.amount as! Float
////                spesa += intent.amount as! Float
////            }
//        completion(AddExpenseIntentResponse.init(code: .success, userActivity: nil))
//    }

}
