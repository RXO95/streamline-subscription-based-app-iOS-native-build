import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        NavigationView {
            VStack {
                
                if cartManager.items.isEmpty {
                    VStack {
                        Image(systemName: "cart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding()
                        Text("Your Cart is Empty")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.subscriptionName)
                                        .font(.headline)
                                    Text(item.planName)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("₹\(String(format: "%.2f", item.price))")
                                    .font(.body)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                   
                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("₹\(String(format: "%.2f", cartManager.totalPrice))")
                            .font(.headline)
                    }
                    .padding()

                  
                    Button(action: {
                       
                    }) {
                        Text("Pay")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("My Cart")
            .toolbar {
                if !cartManager.items.isEmpty {
                    EditButton()
                }
            }
        }
    }

   
    private func deleteItems(at offsets: IndexSet) {
        let itemsToRemove = offsets.map { cartManager.items[$0] }
        for item in itemsToRemove {
            cartManager.removeFromCart(item: item)
        }
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
      
        let authVM = AuthViewModel()
        let cartM = CartManager(authViewModel: authVM)
        
        
        let sampleItem = CartItem(id: "1", subscriptionID: "netflix", planID: "premium", planName: "Premium", subscriptionName: "Netflix", price: 649.0)
        cartM.items.append(sampleItem)
        
    
        return CartView()
            .environmentObject(cartM)
            .environmentObject(authVM)
    }
}
