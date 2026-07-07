import SwiftUI

enum Theme {
    static let accent = Color(hex: "#8A5CD6")
    static let background = Color(hex: "#120F17")
    static let backgroundSecondary = Color(hex: "#1B1622")
    static let card = Color(hex: "#241C2C")
    static let textPrimary = Color(hex: "#EEE8F5")
    static let textSecondary = Color(hex: "#B7A6CF")

    static let titleFont = Font.system(.title2, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .default)
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
