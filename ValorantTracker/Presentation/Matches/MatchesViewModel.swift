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
    private let getRecentMatches: GetRecentMatchesUseCase

    init(riotID: RiotID, getRecentMatches: GetRecentMatchesUseCase) {
        self.riotID = riotID
        self.getRecentMatches = getRecentMatches
    }

    func load() {
        state = .loading
        Task {
            do {
                let matches = try await getRecentMatches.execute(riotID: riotID, limit: 20)
                state = .loaded(matches)
            } catch {
                state = .failed(message: error.localizedDescription)
            }
        }
    }
}
