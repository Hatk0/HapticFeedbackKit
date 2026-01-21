import Foundation
#if canImport(CoreHaptics)
import CoreHaptics

public struct CustomHapticPattern {
    public let pattern: CHHapticPattern

    public init(_ pattern: CHHapticPattern) {
        self.pattern = pattern
    }
}
#endif

public enum HapticPattern {
    public enum ImpactStyle {
        case light
        case medium
        case heavy
        case soft
        case rigid
    }

    public enum NotificationType {
        case success
        case warning
        case error
    }

    case impact(ImpactStyle)
    case notification(NotificationType)
    case selection
#if canImport(CoreHaptics)
    case custom(CustomHapticPattern)
#endif
}
