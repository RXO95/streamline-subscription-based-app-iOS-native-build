import SwiftUI

struct PlanRowView: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    
    var body: some View {
        HStack {
            
            Circle()
                .stroke(isSelected ? Color.blue : Color.gray, lineWidth: 2)
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(isSelected ? Color.blue : Color.clear)
                        .frame(width: 12, height: 12)
                )
            
            VStack(alignment: .leading) {
                Text(plan.name)
                    .font(.headline)
                // FIX: Formatted the price (Double) as a currency string for display.
                Text("₹\(String(format: "%.2f", plan.price))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}


struct PlanRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            PlanRowView(plan: Subscription.allSubscriptions[0].plans[0], isSelected: true)
            PlanRowView(plan: Subscription.allSubscriptions[0].plans[1], isSelected: false)
        }
        .padding()
    }
}

