import Foundation

/// A Riot ID as players type it: "name#tag".
struct RiotID: Equatable {
    let name: String
    let tag: String

    /// Returns nil unless the text has a non-empty name and tag around the last "#".
    init?(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let separator = trimmed.lastIndex(of: "#") else { return nil }
        let name = trimmed[..<separator].trimmingCharacters(in: .whitespaces)
        let tag = trimmed[trimmed.index(after: separator)...].trimmingCharacters(in: .whitespaces)
        guard !name.isEmpty, !tag.isEmpty else { return nil }
        self.name = name
        self.tag = tag
    }

    var display: String { "\(name)#\(tag)" }
}
