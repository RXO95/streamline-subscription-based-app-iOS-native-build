import SwiftUI

struct SubscriptionCardView: View {
    let subscription: Subscription

    var body: some View {
        VStack {
            
            Image(subscription.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)

            Text(subscription.name)
                .font(.headline)
                .padding(.top, 5)

            NavigationLink(destination: SubscriptionDetailView(subscription: subscription)) {
                Text("Check it out")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct SubscriptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCardView(subscription: Subscription.allSubscriptions[0])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

