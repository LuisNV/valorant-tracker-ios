import UIKit

/// Owns navigation. View controllers report events through closures and never push each other.
@MainActor
final class AppCoordinator {

    private let window: UIWindow
    private let playerService: PlayerService
    private let navigationController = UINavigationController()

    init(window: UIWindow, playerService: PlayerService) {
        self.window = window
        self.playerService = playerService
    }

    func start() {
        let viewModel = SearchViewModel(playerService: playerService)
        viewModel.onFound = { [weak self] riotID, profile in
            self?.showProfile(riotID: riotID, profile: profile)
        }
        navigationController.viewControllers = [SearchViewController(viewModel: viewModel)]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showProfile(riotID: RiotID, profile: PlayerProfile) {
        let viewController = ProfileViewController(viewModel: ProfileViewModel(profile: profile))
        viewController.onShowMatches = { [weak self] in
            self?.showMatches(riotID: riotID)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showMatches(riotID: RiotID) {
        let viewModel = MatchesViewModel(riotID: riotID, playerService: playerService)
        navigationController.pushViewController(MatchesViewController(viewModel: viewModel), animated: true)
    }
}
