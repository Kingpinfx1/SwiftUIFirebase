//
//  SwiftUIFirebaseApp.swift
//  SwiftUIFirebase
//
//  Created by kingpin on 5/29/25.
//

import SwiftUI
import Firebase

@main
struct SwiftUIFirebaseApp: App {
    
   @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    } 
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
