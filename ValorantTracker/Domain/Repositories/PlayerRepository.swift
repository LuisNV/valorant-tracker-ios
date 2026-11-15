import Foundation

/// What the domain needs from the outside world. Implemented in the Data layer.
protocol PlayerRepository {
    func profile(for riotID: RiotID) async throws -> PlayerProfile
    func recentMatches(for riotID: RiotID, limit: Int) async throws -> [MatchSummary]
}
