import Foundation

/// MatchRepository backed by the tracker backend.
final class APIMatchRepository: MatchRepository {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func recentMatches(for riotID: RiotID, limit: Int) async throws -> [MatchSummary] {
        let dtos: [MatchSummaryDTO] = try await client.get(
            ["api", "v1", "players", riotID.name, riotID.tag, "matches"],
            query: [URLQueryItem(name: "limit", value: String(limit))]
        )
        return dtos.map { $0.toDomain() }
    }
}
