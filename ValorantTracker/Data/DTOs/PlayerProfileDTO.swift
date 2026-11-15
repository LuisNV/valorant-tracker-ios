import Foundation

/// Mirrors PlayerProfileResponse in the backend.
struct PlayerProfileDTO: Decodable {
    let puuid: String
    let name: String
    let tag: String
    let region: String
    let accountLevel: Int

    func toDomain() -> PlayerProfile {
        PlayerProfile(puuid: puuid, name: name, tag: tag, region: region, accountLevel: accountLevel)
    }
}
