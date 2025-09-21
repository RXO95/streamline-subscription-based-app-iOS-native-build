import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var searchText = ""

    let allSubscriptions = Subscription.allSubscriptions


    var filteredSubscriptions: [Subscription] {
        if searchText.isEmpty {
            return allSubscriptions
        } else {
            return allSubscriptions.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredSubscriptions) { subscription in
                            NavigationLink(destination: SubscriptionDetailView(subscription: subscription)) {
                                SubscriptionCardView(subscription: subscription)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Recommended")
                .searchable(text: $searchText, prompt: "Search Subscriptions")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "bell")
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

