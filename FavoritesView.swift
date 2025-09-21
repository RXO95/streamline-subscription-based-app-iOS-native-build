import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    let allSubscriptions: [Subscription] = Subscription.allSubscriptions


    var favoriteSubscriptions: [Subscription] {
        allSubscriptions.filter { favoritesManager.isFavorite(subscriptionID: $0.id) }
    }

    var body: some View {
        NavigationView {
            VStack {
                if favoriteSubscriptions.isEmpty {
                    Text("No Favorites Yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    List(favoriteSubscriptions) { subscription in
                        HStack {
                            Image(subscription.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(subscription.name)
                                    .font(.headline)
                                Text(subscription.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
