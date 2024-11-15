//
//  LogEntryAppIntent.swift
//  widgetExtensionExtension
//
//  Created by Alex Saha on 11/15/24.
//

import Foundation
import AppIntents
import SwiftUI

struct LogEntry: AppIntent{
    
    static var title: LocalizedStringResource = "Update widget"
    
    static var description: IntentDescription = "Brings widget up to date with app's current data"
    
    func perform() async throws -> some IntentResult & ReturnsValue {
        let storageManager = StorageManager()
        storageManager.log()
        
        return .result(value: storageManager.progress())
    }
    
    
}
