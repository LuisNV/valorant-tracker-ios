import Foundation

/// One match result for a player. Hashable so lists can diff it.
struct MatchSummary: Hashable {
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
