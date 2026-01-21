import XCTest
@testable import HapticFeedbackKit

@MainActor
final class HapticFeedbackKitTests: XCTestCase {
    func testEngineDelegatesToProvider() {
        let provider = TestProvider()
        let engine = HapticEngine(provider: provider)

        engine.prepare(.selection)
        engine.play(.selection)

        XCTAssertEqual(provider.prepareCount, 1)
        XCTAssertEqual(provider.playCount, 1)
        XCTAssertTrue(engine.supportsHaptics)
    }
}

private final class TestProvider: HapticProvider {
    var supportsHaptics: Bool { true }
    var prepareCount = 0
    var playCount = 0

    func prepare(_ pattern: HapticPattern) {
        prepareCount += 1
    }

    func play(_ pattern: HapticPattern) {
        playCount += 1
    }
}
