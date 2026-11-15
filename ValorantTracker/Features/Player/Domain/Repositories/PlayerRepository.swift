import Foundation

/// What the Player feature needs from the outside world. Implemented in its Data layer.
protocol PlayerRepository {
    func profile(for riotID: RiotID) async throws -> PlayerProfile
}
