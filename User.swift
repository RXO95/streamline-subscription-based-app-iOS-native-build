import FirebaseFirestore
import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    
    var username: String
    var profileImageURL: String?
}

