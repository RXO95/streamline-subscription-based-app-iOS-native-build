import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Header
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    Text(authViewModel.currentUser?.username ?? "Username")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(authViewModel.currentUser?.email ?? "email@example.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)
                
                
                Form {
                    Section(header: Text("My Account")) {
                        Text("Purchase History")
                        NavigationLink(destination: SettingsView()) {
                            Text("Settings")
                        }
                    }

                    Section {
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true) // Hide the bar for a cleaner look
        }
    }
}

