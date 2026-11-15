import Foundation

protocol PlayerService {
    func profile(for riotID: RiotID) async throws -> PlayerProfile
    func recentMatches(for riotID: RiotID, limit: Int) async throws -> [MatchSummary]
}

final class APIPlayerService: PlayerService {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func profile(for riotID: RiotID) async throws -> PlayerProfile {
        try await client.get(["api", "v1", "players", riotID.name, riotID.tag])
    }

    func recentMatches(for riotID: RiotID, limit: Int) async throws -> [MatchSummary] {
        try await client.get(
            ["api", "v1", "players", riotID.name, riotID.tag, "matches"],
            query: [URLQueryItem(name: "limit", value: String(limit))]
        )
    }
}
