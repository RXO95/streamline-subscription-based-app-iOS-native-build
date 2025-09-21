import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username: String = ""
   
    
    var body: some View {
        Form {
            Section(header: Text("Public Profile")) {
                TextField("Username", text: $username)
            }
            
            Button(action: {
                Task {
                 
                    await authViewModel.updateUsername(username)
                }
            }) {
                Text("Save Changes")
            }
        }
        .navigationTitle("Edit Profile")
        .onAppear {
            
            self.username = authViewModel.currentUser?.username ?? ""
        }
    }
}
