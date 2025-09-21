import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine


struct CartItem: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    let subscriptionID: String
    let planID: String
    let planName: String
    let subscriptionName: String
    let price: Double
}

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    
  
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    private var authViewModel: AuthViewModel
    private var cancellables = Set<AnyCancellable>()

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
       
        authViewModel.$userSession.sink { [weak self] user in
            if let user = user {
                self?.fetchCart(for: user.uid)
            } else {
                self?.stopListening()
            }
        }.store(in: &cancellables)
    }

    deinit {
        stopListening()
    }

    func stopListening() {
        listenerRegistration?.remove()
        self.items = []
    }

    func fetchCart(for userID: String) {
        stopListening()
        let query = db.collection("users").document(userID).collection("cart")
        
        listenerRegistration = query.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching cart: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            
            self.items = documents.compactMap { document in
                try? document.data(as: CartItem.self)
            }
        }
    }

    func addToCart(subscription: Subscription, plan: SubscriptionPlan) {
        guard let userID = authViewModel.userSession?.uid else { return }
        
        
        let newItem = CartItem(
            subscriptionID: subscription.id,
            planID: plan.id.uuidString,
            planName: plan.name,
            subscriptionName: subscription.name,
            price: plan.price
        )

        do {
            
            _ = try db.collection("users").document(userID).collection("cart").addDocument(from: newItem)
        } catch {
            print("Error adding to cart: \(error.localizedDescription)")
        }
    }

    func removeFromCart(item: CartItem) {
        guard let userID = authViewModel.userSession?.uid, let itemID = item.id else { return }
        
       
        db.collection("users").document(userID).collection("cart").document(itemID).delete()
    }
}

