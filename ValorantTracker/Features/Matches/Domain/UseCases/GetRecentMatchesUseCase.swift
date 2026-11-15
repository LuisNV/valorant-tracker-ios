import Foundation

protocol GetRecentMatchesUseCase {
    func execute(riotID: RiotID, limit: Int) async throws -> [MatchSummary]
}

final class DefaultGetRecentMatchesUseCase: GetRecentMatchesUseCase {

    private let repository: MatchRepository

    init(repository: MatchRepository) {
        self.repository = repository
    }

    func execute(riotID: RiotID, limit: Int) async throws -> [MatchSummary] {
        try await repository.recentMatches(for: riotID, limit: limit)
    }
}
