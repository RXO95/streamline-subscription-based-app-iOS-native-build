import SwiftUI

struct WelcomeView: View {

    @Binding var showingWelcome: Bool

    var body: some View {
        VStack {
            Spacer()
            
           
            ZStack {
                
                Image("apple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(15))
                    .offset(x: -90, y: -120)

           
                Image("amazonprime")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(20))
                    .offset(x: 90, y: -80)
                
             
                Image("netflix")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .rotationEffect(.degrees(-25))
                    .offset(x: -100, y: 10)

                
                Image("youtube")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: 50, y: 40)

               
                Image("spotify")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .offset(x: -60, y: 120)
            }
            .frame(height: 300)
            
            Spacer()
            
            
            Text("Streamline Prototype")
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            
            Text("Find the best subscription plan")
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.top, 4)
            
            Spacer()
            
            
            Button(action: {
                
                withAnimation {
                    showingWelcome = false
                }
            }) {
                HStack {
                    Text("Let me start exploring!")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                        .fontWeight(.bold)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(16)
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        WelcomeView(showingWelcome: .constant(true))
    }
}

