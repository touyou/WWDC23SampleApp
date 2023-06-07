//
//  Item.swift
//  WWDC23SampleApp
//
//  Created by 藤井陽介 on 2023/06/07.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    @Attribute(.unique) var name: String
    
    init(timestamp: Date, name: String) {
        self.timestamp = timestamp
        self.name = name
    }
}
