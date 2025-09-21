import Foundation
import Firebase
import FirebaseFirestore
import Combine
import FirebaseAuth
class FavoritesManager: ObservableObject {
    @Published var favoriteIDs: Set<String> = []
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    private var authViewModel: AuthViewModel
    private var listenerRegistration: ListenerRegistration?

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        
        
        authViewModel.$userSession.sink { [weak self] user in
          
            self?.listenerRegistration?.remove()
            if let user = user {
                self?.fetchFavorites(for: user.uid)
            } else {
                // Clear local favorites when the user logs out
                self?.favoriteIDs = []
            }
        }.store(in: &cancellables)
    }

    deinit {
        listenerRegistration?.remove()
    }

    func fetchFavorites(for userId: String) {
        let favoritesCollection = db.collection("users").document(userId).collection("favorites")
        
     
        listenerRegistration = favoritesCollection.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents, error == nil else {
                print("Error fetching favorites: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
      
            let ids = documents.map { $0.documentID }
            DispatchQueue.main.async {
                self?.favoriteIDs = Set(ids)
            }
        }
    }

    func isFavorite(subscriptionID: String) -> Bool {
        favoriteIDs.contains(subscriptionID)
    }

    func toggleFavorite(subscriptionID: String) {
        guard let userId = authViewModel.userSession?.uid else {
            print("Error: User not logged in.")
            return
        }
        
        let favoriteRef = db.collection("users").document(userId).collection("favorites").document(subscriptionID)
        
        if isFavorite(subscriptionID: subscriptionID) {
            
            favoriteRef.delete { [weak self] error in
                if let error = error {
                    print("Error removing favorite: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self?.favoriteIDs.remove(subscriptionID)
                    }
                }
            }
        } else {
            
            favoriteRef.setData([:]) { [weak self] error in
                if let error = error {
                    print("Error adding favorite: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self?.favoriteIDs.insert(subscriptionID)
                    }
                }
            }
        }
    }
}

