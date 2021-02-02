//
//  fireAppApp.swift
//  fireApp
//
//  Created by David Svensson on 2021-02-02.
//

import SwiftUI
import Firebase

@main
struct fireAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
