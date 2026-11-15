import Foundation

@MainActor
final class SearchViewModel {

    enum State: Equatable {
        case idle
        case loading
        case failed(message: String)
    }

    private(set) var state: State = .idle {
        didSet { onStateChange?(state) }
    }

    var onStateChange: ((State) -> Void)?
    var onFound: ((RiotID, PlayerProfile) -> Void)?

    private let playerService: PlayerService

    init(playerService: PlayerService) {
        self.playerService = playerService
    }

    func search(text: String) {
        guard state != .loading else { return }
        guard let riotID = RiotID(text) else {
            state = .failed(message: "Nhập Riot ID theo dạng tên#tag, ví dụ SenNho#VN2.")
            return
        }

        state = .loading
        Task {
            do {
                let profile = try await playerService.profile(for: riotID)
                state = .idle
                onFound?(riotID, profile)
            } catch {
                state = .failed(message: error.localizedDescription)
            }
        }
    }
}
