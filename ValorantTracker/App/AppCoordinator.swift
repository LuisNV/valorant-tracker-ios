import UIKit

/// Owns navigation. View controllers report events through closures and never push each other.
@MainActor
final class AppCoordinator {

    private let window: UIWindow
    private let container: AppDIContainer
    private let navigationController = UINavigationController()

    init(window: UIWindow, container: AppDIContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        let viewModel = container.makeSearchViewModel()
        viewModel.onFound = { [weak self] riotID, profile in
            self?.showProfile(riotID: riotID, profile: profile)
        }
        navigationController.viewControllers = [SearchViewController(viewModel: viewModel)]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showProfile(riotID: RiotID, profile: PlayerProfile) {
        let viewController = ProfileViewController(viewModel: container.makeProfileViewModel(profile: profile))
        viewController.onShowMatches = { [weak self] in
            self?.showMatches(riotID: riotID)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showMatches(riotID: RiotID) {
        let viewModel = container.makeMatchesViewModel(riotID: riotID)
        navigationController.pushViewController(MatchesViewController(viewModel: viewModel), animated: true)
    }
}
