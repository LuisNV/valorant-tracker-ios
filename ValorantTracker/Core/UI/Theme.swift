import UIKit

/// Colors and fonts from the design canvas.
enum Theme {

    enum Color {
        static let background = UIColor(hex: 0x0E1116)
        static let surface = UIColor(hex: 0x171C24)
        static let border = UIColor(hex: 0x2A3340)
        static let textPrimary = UIColor(hex: 0xF2F4F7)
        static let textSecondary = UIColor(hex: 0x9AA4B2)
        static let accent = UIColor(hex: 0x6C9BFF)
        static let win = UIColor(hex: 0x8FB3FF)
        static let loss = UIColor(hex: 0xFFB27A)
    }

    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }

    static func applyAppearance() {
        let navigationBar = UINavigationBarAppearance()
        navigationBar.configureWithOpaqueBackground()
        navigationBar.backgroundColor = Color.background
        navigationBar.titleTextAttributes = [.foregroundColor: Color.textPrimary]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: Color.textPrimary]
        UINavigationBar.appearance().standardAppearance = navigationBar
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBar
        UINavigationBar.appearance().tintColor = Color.accent
    }
}

extension UIColor {
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
