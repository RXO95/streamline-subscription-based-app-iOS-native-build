import SwiftUI

struct SubscriptionDetailView: View {
    let subscription: Subscription
    @State private var selectedPlan: SubscriptionPlan?
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack {
                    Image(subscription.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .padding(20)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                        .padding(.top)
                    
                    Text(subscription.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)

              
                VStack(alignment: .leading, spacing: 10) {
                    Text(subscription.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(String(format: "%.1f", subscription.rating)) (\(subscription.reviewCount))")
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal)

                
                VStack(alignment: .leading) {
                    Text("Choose a plan")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(subscription.plans) { plan in
                        PlanRowView(plan: plan, isSelected: selectedPlan == plan)
                            .onTapGesture {
                                self.selectedPlan = plan
                            }
                    }
                }
                .padding(.horizontal)

               
                HStack(spacing: 20) {
                    Button(action: {
                        favoritesManager.toggleFavorite(subscriptionID: subscription.id)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(subscriptionID: subscription.id) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(favoritesManager.isFavorite(subscriptionID: subscription.id) ? .red : .primary)
                    }
                    
                    Button(action: addToCart) {
                        Text("Add to Cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(selectedPlan == nil ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(selectedPlan == nil)
                }
                .padding()
            }
        }
        .navigationTitle(subscription.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addToCart() {
        guard let plan = selectedPlan else { return }
        cartManager.addToCart(subscription: subscription, plan: plan)
    }
}


struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let authVM = AuthViewModel()
        return NavigationView {
            SubscriptionDetailView(subscription: Subscription.allSubscriptions[0])
                .environmentObject(authVM)
                .environmentObject(CartManager(authViewModel: authVM))
                .environmentObject(FavoritesManager(authViewModel: authVM))
        }
    }
}

