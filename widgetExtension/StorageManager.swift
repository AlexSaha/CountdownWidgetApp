//
//  StoreageManager.swift
//  widgetExtensionExtension
//
//  Created by Alex Saha on 11/15/24.
//

import Foundation
import SwiftUI

struct StorageManager {
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.com.alexander.www.CountdownWidget")) private var streak = 0
    
    func log() {
        streak += 1
    }
    
    func progress() -> Int {
        return streak
    }
}
