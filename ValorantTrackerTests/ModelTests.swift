import XCTest
@testable import ValorantTracker

final class ModelTests: XCTestCase {

    func testRiotIDParsesNameAndTag() {
        let riotID = RiotID("  SenNho#VN2 ")
        XCTAssertEqual(riotID?.name, "SenNho")
        XCTAssertEqual(riotID?.tag, "VN2")
    }

    func testRiotIDSplitsOnLastHash() {
        let riotID = RiotID("a#b#c")
        XCTAssertEqual(riotID?.name, "a#b")
        XCTAssertEqual(riotID?.tag, "c")
    }

    func testRiotIDRejectsMissingParts() {
        XCTAssertNil(RiotID("SenNho"))
        XCTAssertNil(RiotID("#VN2"))
        XCTAssertNil(RiotID("SenNho#"))
    }

    func testPlayerProfileDecodes() throws {
        let json = Data("""
        {"puuid":"abc","name":"SenNho","tag":"VN2","region":"ap","accountLevel":148}
        """.utf8)
        let profile = try APIClient.makeDecoder().decode(PlayerProfile.self, from: json)
        XCTAssertEqual(profile.accountLevel, 148)
        XCTAssertEqual(profile.region, "ap")
    }

    func testMatchSummaryDecodesDatesWithAndWithoutFraction() throws {
        let template = """
        {"matchId":"m1","map":"Ascent","mode":"Competitive","agent":"Jett","kills":21,"deaths":14,
         "assists":5,"score":271,"roundsWon":13,"roundsLost":9,"won":true,"startedAt":"%@"}
        """
        for date in ["2026-11-15T10:00:00Z", "2026-11-15T10:00:00.123456Z"] {
            let json = Data(String(format: template, date).utf8)
            let match = try APIClient.makeDecoder().decode(MatchSummary.self, from: json)
            XCTAssertEqual(match.map, "Ascent")
        }
    }
}
