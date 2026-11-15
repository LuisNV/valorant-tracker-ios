import Foundation

/// Composition root: the only place that knows which concrete types back each protocol.
@MainActor
final class AppDIContainer {

    private lazy var apiClient = APIClient(baseURL: AppConfig.baseURL)
    private lazy var playerRepository: PlayerRepository = APIPlayerRepository(client: apiClient)

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(getPlayerProfile: DefaultGetPlayerProfileUseCase(repository: playerRepository))
    }

    func makeProfileViewModel(profile: PlayerProfile) -> ProfileViewModel {
        ProfileViewModel(profile: profile)
    }

    func makeMatchesViewModel(riotID: RiotID) -> MatchesViewModel {
        MatchesViewModel(
            riotID: riotID,
            getRecentMatches: DefaultGetRecentMatchesUseCase(repository: playerRepository)
        )
    }
}
