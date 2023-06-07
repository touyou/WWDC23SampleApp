//
//  WWDC23SampleAppApp.swift
//  WWDC23SampleApp
//
//  Created by 藤井陽介 on 2023/06/07.
//

import SwiftUI
import SwiftData

@main
struct WWDC23SampleAppApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
