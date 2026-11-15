import Foundation

protocol GetPlayerProfileUseCase {
    func execute(riotID: RiotID) async throws -> PlayerProfile
}

final class DefaultGetPlayerProfileUseCase: GetPlayerProfileUseCase {

    private let repository: PlayerRepository

    init(repository: PlayerRepository) {
        self.repository = repository
    }

    func execute(riotID: RiotID) async throws -> PlayerProfile {
        try await repository.profile(for: riotID)
    }
}
