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
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var name: String
    
    init(timestamp: Date, name: String) {
        self.id = UUID()
        self.timestamp = timestamp
        self.name = name
    }
}
