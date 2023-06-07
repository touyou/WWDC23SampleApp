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
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
