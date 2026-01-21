import XCTest
@testable import HapticFeedbackKitExtras

#if os(iOS)
import UIKit
#endif
#if canImport(GameController)
import GameController
import CoreHaptics
#endif

/// Smoke tests for the extras module availability.
final class HapticFeedbackKitExtrasTests: XCTestCase {
    
    /// Confirms the extras module is loadable.
    func testExtrasModuleLoads() {
        XCTAssertTrue(true)
    }

    /// Ensures API symbols are visible under expected platform gates.
    func testCompileTimeAvailability() {
        #if os(iOS)
        if #available(iOS 17.5, *) {
            _ = ApplePencilHaptics.self
        }
        #endif

        #if canImport(GameController)
        if #available(iOS 14.0, tvOS 14.0, macOS 11.0, *) {
            _ = GameControllerHaptics.self
            _ = GCHapticsLocality.default
        }
        #endif
    }
}
