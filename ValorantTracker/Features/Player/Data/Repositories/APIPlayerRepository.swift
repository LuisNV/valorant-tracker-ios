import Foundation

/// PlayerRepository backed by the tracker backend.
final class APIPlayerRepository: PlayerRepository {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func profile(for riotID: RiotID) async throws -> PlayerProfile {
        let dto: PlayerProfileDTO = try await client.get(["api", "v1", "players", riotID.name, riotID.tag])
        return dto.toDomain()
    }
}
