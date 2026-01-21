import Foundation

/// Internal protocol for platform-specific haptic adapters.
protocol HapticProvider {
    /// Indicates whether the platform can perform haptics.
    var supportsHaptics: Bool { get }
    /// Prepares resources for a pattern when supported.
    func prepare(_ pattern: HapticPattern)
    /// Plays a pattern on the platform.
    func play(_ pattern: HapticPattern)
}
