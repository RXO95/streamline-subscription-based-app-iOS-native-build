import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
  
    static let shared = AuthViewModel()
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.userSession = user
                if user != nil {
                    self?.fetchUser()
                } else {
                    self?.currentUser = nil
                }
            }
        }
    }

    func signIn() async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signUp() async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = User(id: result.user.uid, email: self.email, username: self.username)
        
        let db = Firestore.firestore()
        try await db.collection("users").document(result.user.uid).setData([
            "username": user.username,
            "email": user.email,
            "uid": user.id
        ])
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func sendPasswordReset() async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found for user")
                return
            }
            DispatchQueue.main.async {
                let id = data["uid"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                self.currentUser = User(id: id, email: email, username: username)
            }
        }
    }
    
   
    func updateUsername(_ newUsername: String) async {
        guard let uid = currentUser?.id else { return }
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        do {
            try await userRef.updateData(["username": newUsername])
          
            self.currentUser?.username = newUsername
            print("Username updated successfully.")
        } catch {
            print("Error updating username: \(error.localizedDescription)")
        }
    }
}

