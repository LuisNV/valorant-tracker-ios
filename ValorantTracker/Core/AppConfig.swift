import Foundation

enum AppConfig {
    /// Backend address. On a real device, replace localhost with your Mac's LAN IP.
    static let baseURL = URL(string: "http://localhost:8080")!
}
