//
//  ContentView.swift
//  SwiftUIFirebase
//
//  Created by kingpin on 5/29/25.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel

    
    var body: some View {
        if viewModel.userSession != nil{
            ProfileView()
        } else {
            LoginView()
        }
    }
    

}

#Preview {
    ContentView()
}
