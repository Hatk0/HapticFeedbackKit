// Defines cross-platform haptic patterns and optional Core Haptics wrappers.
import Foundation
#if canImport(CoreHaptics)
import CoreHaptics

/// Wraps a Core Haptics pattern for use with `HapticPattern.custom`.
public struct CustomHapticPattern {
    public let pattern: CHHapticPattern

    /// Creates a wrapper for a Core Haptics pattern.
    public init(_ pattern: CHHapticPattern) {
        self.pattern = pattern
    }
}
#endif

/// Cross-platform patterns supported by `HapticEngine`.
public enum HapticPattern {
    /// Impact intensity variants for tactile taps.
    public enum ImpactStyle {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }

    /// Notification feedback variants for success/warning/error.
    public enum NotificationType {
        case success
        case warning
        case error
    }

    /// Short impact feedback with a specific style.
    case impact(ImpactStyle)
    /// Notification feedback for success, warning, or error.
    case notification(NotificationType)
    /// Selection change feedback for incremental UI changes.
    case selection
#if canImport(CoreHaptics)
    /// Custom Core Haptics pattern (iOS/iPadOS only).
    case custom(CustomHapticPattern)
#endif
}
