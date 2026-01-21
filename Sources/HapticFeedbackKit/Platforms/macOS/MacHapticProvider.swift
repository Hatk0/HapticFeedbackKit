#if os(macOS)
import AppKit

/// macOS provider that maps patterns to `NSHapticFeedbackManager`.
final class MacHapticProvider: HapticProvider {
    
    /// macOS supports basic system haptics.
    var supportsHaptics: Bool { true }

    /// No preparation required on macOS.
    func prepare(_ pattern: HapticPattern) {}

    /// Plays the mapped macOS haptic feedback pattern.
    func play(_ pattern: HapticPattern) {
        let feedbackPattern: NSHapticFeedbackManager.FeedbackPattern
        switch pattern {
        case .impact(let style):
            feedbackPattern = impactFeedbackPattern(for: style)
        case .notification:
            feedbackPattern = .generic
        case .selection:
            feedbackPattern = .alignment
#if canImport(CoreHaptics)
        case .custom:
            return
#endif
        }

        NSHapticFeedbackManager.defaultPerformer.perform(feedbackPattern, performanceTime: .now)
    }

    /// Maps impact styles to macOS feedback patterns.
    private func impactFeedbackPattern(for style: HapticPattern.ImpactStyle) -> NSHapticFeedbackManager.FeedbackPattern {
        switch style {
        case .light, .soft:
            return .alignment
        case .medium:
            return .levelChange
        case .heavy, .rigid:
            return .generic
        }
    }
}
#endif
