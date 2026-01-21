import XCTest
@testable import HapticFeedbackKit

/// Verifies public engine behavior via a test provider.
@MainActor
final class HapticFeedbackKitTests: XCTestCase {
    
    /// Ensures the engine forwards calls to its provider.
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

/// Simple provider stub that counts calls.
private final class TestProvider: HapticProvider {
    
    /// Reports support to keep test expectations simple.
    var supportsHaptics: Bool { true }
    var prepareCount = 0
    var playCount = 0

    /// Records prepare calls.
    func prepare(_ pattern: HapticPattern) {
        prepareCount += 1
    }

    /// Records play calls.
    func play(_ pattern: HapticPattern) {
        playCount += 1
    }
}
