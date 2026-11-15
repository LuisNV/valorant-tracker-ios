import Foundation

/// A player as the app understands it. No networking or UI concerns here.
struct PlayerProfile: Equatable {
    let puuid: String
    let name: String
    let tag: String
    let region: String
    let accountLevel: Int
}
