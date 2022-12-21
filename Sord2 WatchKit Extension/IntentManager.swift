//
//  IntentManager.swift
//  Sord2 WatchKit Extension
//
//  Created by Eugenia Esposito on 03/02/2020.
//  Copyright © 2020 iOS Foundation. All rights reserved.
//

import Foundation
import Intents

class IntentManager {
    static let shared = IntentManager()
    
    func intent(withAmount amount: NSNumber, withCategory category: CategoryType) -> AddExpenseIntent {
        let intent = AddExpenseIntent()
        intent.amount = amount
        intent.category = category
        return intent
    }
    
    func donateShortcuts(withIntent intent: INIntent) {
        var relevantShortcuts: [INRelevantShortcut] = []
        if let relevantShortcut = defaultRelevantShortcut(withIntent: intent) {
            relevantShortcuts.append(relevantShortcut)
        }
        
        INRelevantShortcutStore.default.setRelevantShortcuts(relevantShortcuts) { (error) in
            if let error = error {
                print("Failed to set relevant shortcuts: \(error))")
            } else {
                print("Relevant shortcuts set.")
            }
        }
    }
    
    private func defaultRelevantShortcut(withIntent intent: INIntent) -> INRelevantShortcut? {
        if let shortcut = INShortcut(intent: intent) {
            let relevantShortcut = INRelevantShortcut(shortcut: shortcut)
            relevantShortcut.shortcutRole = .information
            return relevantShortcut
        }
        return nil
    }
    
    private func dateRelevanceProvider() -> INDateRelevanceProvider {
        let start = Date()
        let end = start.addingTimeInterval(60*60)
        return INDateRelevanceProvider(start: start, end: end)
    }
}
