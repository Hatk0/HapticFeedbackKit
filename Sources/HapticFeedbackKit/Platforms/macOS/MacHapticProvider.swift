#if os(macOS)
import AppKit

final class MacHapticProvider: HapticProvider {
    var supportsHaptics: Bool { true }

    func prepare(_ pattern: HapticPattern) {}

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
