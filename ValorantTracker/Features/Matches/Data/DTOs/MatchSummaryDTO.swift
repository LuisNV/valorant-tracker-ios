import Foundation

/// Mirrors MatchSummaryResponse in the backend.
struct MatchSummaryDTO: Decodable {
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

    func toDomain() -> MatchSummary {
        MatchSummary(
            matchId: matchId, map: map, mode: mode, agent: agent,
            kills: kills, deaths: deaths, assists: assists, score: score,
            roundsWon: roundsWon, roundsLost: roundsLost, won: won, startedAt: startedAt
        )
    }
}
