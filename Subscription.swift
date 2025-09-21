import Foundation


struct SubscriptionPlan: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    
    let price: Double
    let features: [String]

   
    enum CodingKeys: String, CodingKey {
        case name, price, features
    }
}


struct Subscription: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let imageName: String
    let description: String
    let rating: Double
    let reviewCount: String
    let plans: [SubscriptionPlan]
    
   
    static let allSubscriptions: [Subscription] = [
        Subscription(
            id: "netflix",
            name: "Netflix",
            imageName: "netflix",
            description: "Get Netflix subscription for the lowest price possible.",
            rating: 4.9,
            reviewCount: "2.5k reviews",
            plans: [
                SubscriptionPlan(name: "Mobile", price: 149, features: ["Mobile only"]),
                SubscriptionPlan(name: "Basic", price: 199, features: ["Basic features"]),
                SubscriptionPlan(name: "Standard", price: 499, features: ["Standard features"]),
                SubscriptionPlan(name: "Premium", price: 649, features: ["Premium features"])
            ]
        ),
        Subscription(
            id: "youtube_premium",
            name: "Youtube Premium",
            imageName: "youtube",
            description: "Enjoy ad-free YouTube and YouTube Music.",
            rating: 4.8,
            reviewCount: "3.1k reviews",
            plans: [
                SubscriptionPlan(name: "Individual", price: 129, features: ["1 account"]),
                SubscriptionPlan(name: "Family", price: 189, features: ["Up to 5 members"]),
                SubscriptionPlan(name: "Student", price: 79, features: ["Eligible students only"])
            ]
        ),
        Subscription(
            id: "amazon_prime",
            name: "Amazon Prime",
            imageName: "amazonprime",
            description: "Shopping, streaming, and more.",
            rating: 4.7,
            reviewCount: "4.2k reviews",
            plans: [
                SubscriptionPlan(name: "Monthly", price: 179, features: ["Billed monthly"]),
                SubscriptionPlan(name: "Annual", price: 1499, features: ["Billed annually"])
            ]
        ),
        Subscription(
            id: "spotify",
            name: "Spotify",
            imageName: "spotify",
            description: "Music for everyone.",
            rating: 4.9,
            reviewCount: "5.5k reviews",
            plans: [
                SubscriptionPlan(name: "Mini", price: 7, features: ["1 day, mobile only"]),
                SubscriptionPlan(name: "Individual", price: 119, features: ["1 account"]),
                SubscriptionPlan(name: "Duo", price: 149, features: ["2 accounts"]),
                SubscriptionPlan(name: "Family", price: 179, features: ["6 accounts"])
            ]
        ),
        Subscription(
            id: "apple_tv",
            name: "Apple TV+",
            imageName: "apple",
            description: "Original stories from the most creative minds in TV and film.",
            rating: 4.6,
            reviewCount: "1.8k reviews",
            plans: [
                SubscriptionPlan(name: "Monthly", price: 99, features: ["Billed monthly"])
            ]
        ),
        Subscription(
            id: "crunchyroll",
            name: "Crunchyroll",
            imageName: "crunchyroll",
            description: "The world's largest collection of anime.",
            rating: 4.8,
            reviewCount: "2.9k reviews",
            plans: [
                SubscriptionPlan(name: "Fan", price: 79, features: ["No ads, 1 screen"]),
                SubscriptionPlan(name: "Mega Fan", price: 99, features: ["No ads, 4 screens, offline"])
            ]
        )
    ]
}

