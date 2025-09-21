import SwiftUI
import Firebase

@main
struct StreamlineApp: App {

    @StateObject private var authViewModel: AuthViewModel
    @StateObject private var cartManager: CartManager
    @StateObject private var favoritesManager: FavoritesManager
    @StateObject private var themeManager: ThemeManager
    
   
    @State private var showingWelcomeScreen = true

    init() {
 
        FirebaseApp.configure()
        
       
        let authVM = AuthViewModel()
        let cartM = CartManager(authViewModel: authVM)
        let favM = FavoritesManager(authViewModel: authVM)
        let themeM = ThemeManager()
        
       
        _authViewModel = StateObject(wrappedValue: authVM)
        _cartManager = StateObject(wrappedValue: cartM)
        _favoritesManager = StateObject(wrappedValue: favM)
        _themeManager = StateObject(wrappedValue: themeM)
    }

    var body: some Scene {
        WindowGroup {
            AppRouterView()
               
                .environmentObject(authViewModel)
                .environmentObject(cartManager)
                .environmentObject(favoritesManager)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}


struct AppRouterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showingWelcomeScreen = true

    var body: some View {
        if showingWelcomeScreen {
            WelcomeView(showingWelcome: $showingWelcomeScreen)
        } else {
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                HomeView()
            }
        }
    }
}

