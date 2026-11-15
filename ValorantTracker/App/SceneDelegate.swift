import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        let apiClient = APIClient(baseURL: AppConfig.baseURL)
        let coordinator = AppCoordinator(
            window: window,
            playerService: APIPlayerService(client: apiClient)
        )
        coordinator.start()

        self.window = window
        self.coordinator = coordinator
    }
}
