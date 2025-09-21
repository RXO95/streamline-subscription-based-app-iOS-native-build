import SwiftUI
import Combine

// Enum to represent the available theme options.
enum Theme: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

    var id: String { self.rawValue }
}


class ThemeManager: ObservableObject {
    
    @AppStorage("selectedTheme") private var selectedThemeRawValue: String = Theme.system.rawValue
    
    
    @Published var selectedTheme: Theme = .system
    
    init() {
        
        self.selectedTheme = Theme(rawValue: selectedThemeRawValue) ?? .system
    }
    
   
    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .system:
            return nil // Let the system decide.
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    
    func setTheme(_ theme: Theme) {
        selectedTheme = theme
        selectedThemeRawValue = theme.rawValue
    }
}

