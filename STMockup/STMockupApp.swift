//
//  STMockupApp.swift
//  STMockup
//
//  Created by alfeng on 8/23/24.
//

import SwiftUI
import Firebase

@main
struct STMockupApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
