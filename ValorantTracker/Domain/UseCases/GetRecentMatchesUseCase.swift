import Foundation

protocol GetRecentMatchesUseCase {
    func execute(riotID: RiotID, limit: Int) async throws -> [MatchSummary]
}

final class DefaultGetRecentMatchesUseCase: GetRecentMatchesUseCase {

    private let repository: PlayerRepository

    init(repository: PlayerRepository) {
        self.repository = repository
    }

    func execute(riotID: RiotID, limit: Int) async throws -> [MatchSummary] {
        try await repository.recentMatches(for: riotID, limit: limit)
    }
}
