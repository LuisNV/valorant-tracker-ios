import Foundation

@MainActor
final class MatchesViewModel {

    enum State {
        case loading
        case loaded([MatchSummary])
        case failed(message: String)
    }

    private(set) var state: State = .loading {
        didSet { onStateChange?(state) }
    }

    var onStateChange: ((State) -> Void)?

    let riotID: RiotID
    private let playerService: PlayerService

    init(riotID: RiotID, playerService: PlayerService) {
        self.riotID = riotID
        self.playerService = playerService
    }

    func load() {
        state = .loading
        Task {
            do {
                let matches = try await playerService.recentMatches(for: riotID, limit: 20)
                state = .loaded(matches)
            } catch {
                state = .failed(message: error.localizedDescription)
            }
        }
    }
}
