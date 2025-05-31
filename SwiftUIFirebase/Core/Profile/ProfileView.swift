//
//  ProfileView.swift
//  SwiftUIFirebase
//
//  Created by kingpin on 5/31/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var showDeleteConfirmation = false

    var body: some View {
        if let user = viewModel.currentUser{
            ZStack {
                List {
                    Section{
                        HStack{
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack{
                                Text(user.fullname)
                                    .fontWeight(.bold)
                                Text(user.email)
                                    .font(.caption)
                                Text("Balance: \(user.balance ?? 0.0, specifier: "%.2f")")
                            }
                        }
                    }
                    Section("Account"){
                        
                        Button {
                            viewModel.signOut()
                        } label: {
                            HStack{
                                Image(systemName: "arrow.left.circle.fill")
                                Text("Sign out")
                            }
                            .foregroundStyle(.red)
                        }
                        .disabled(viewModel.isLoading)
                        
                        Button {
                            showDeleteConfirmation = true
                        } label: {
                            HStack{
                                Image(systemName: "xmark.circle.fill")
                                Text("Delete account")
                            }
                            .foregroundStyle(.red)
                        }
                        .disabled(viewModel.isLoading)
                        
                    }
                }
                .refreshable {
                    await viewModel.reloadUser()
                }
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .alert("Delete Account", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    Task {
                        await viewModel.deleteAccount()
                    }
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone.")
            }
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
    }
}

#Preview {
    ProfileView()
}
