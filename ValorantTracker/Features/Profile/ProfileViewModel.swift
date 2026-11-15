import Foundation

@MainActor
final class ProfileViewModel {

    private let profile: PlayerProfile

    init(profile: PlayerProfile) {
        self.profile = profile
    }

    var title: String { "\(profile.name)#\(profile.tag)" }
    var regionText: String { "Khu vực \(profile.region.uppercased())" }
    var levelText: String { "Cấp \(profile.accountLevel)" }
}
