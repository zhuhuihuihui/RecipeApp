//
//  Item.swift
//  RecipeApp
//
//  Created by Scott Zhu on 1/24/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
