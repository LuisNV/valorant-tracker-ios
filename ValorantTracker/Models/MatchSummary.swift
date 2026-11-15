import Foundation

/// Mirrors MatchSummaryResponse in the backend.
struct MatchSummary: Decodable, Hashable {
    let matchId: String
    let map: String
    let mode: String
    let agent: String
    let kills: Int
    let deaths: Int
    let assists: Int
    let score: Int
    let roundsWon: Int
    let roundsLost: Int
    let won: Bool
    let startedAt: Date
}
