import Foundation

/// Mirrors PlayerProfileResponse in the backend.
struct PlayerProfile: Decodable, Equatable {
    let puuid: String
    let name: String
    let tag: String
    let region: String
    let accountLevel: Int
}
