//
//  Item.swift
//  Logger
//
//  Created by Zachary Cohen on 7/26/25.
//

import Foundation
import SwiftData

@Model
final class LogItem {
    var note: String
    var timestamp: Date
    
    init(timestamp: Date, note: String) {
        self.note = note
        self.timestamp = timestamp
    }
}
