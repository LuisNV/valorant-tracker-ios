import Foundation

/// What the Matches feature needs from the outside world. Implemented in its Data layer.
protocol MatchRepository {
    func recentMatches(for riotID: RiotID, limit: Int) async throws -> [MatchSummary]
}
