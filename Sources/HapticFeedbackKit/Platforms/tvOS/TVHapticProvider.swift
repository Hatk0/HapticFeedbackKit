#if os(tvOS)
import Foundation

/// tvOS provider that performs no haptics (platform does not support system haptics).
final class TVHapticProvider: HapticProvider {
    
    /// Always returns false for unsupported haptics.
    var supportsHaptics: Bool { false }
    /// No-op prepare.
    func prepare(_ pattern: HapticPattern) {}
    /// No-op play.
    func play(_ pattern: HapticPattern) {}
}
#endif
