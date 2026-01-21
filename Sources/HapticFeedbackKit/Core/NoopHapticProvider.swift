import Foundation

/// Fallback provider that performs no haptics.
final class NoopHapticProvider: HapticProvider {
    
    /// Always returns false for unsupported haptics.
    var supportsHaptics: Bool { false }
    /// No-op prepare.
    func prepare(_ pattern: HapticPattern) {}
    /// No-op play.
    func play(_ pattern: HapticPattern) {}
}
