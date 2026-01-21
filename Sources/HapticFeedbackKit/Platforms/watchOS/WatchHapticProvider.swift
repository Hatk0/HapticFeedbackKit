#if os(watchOS)
import WatchKit

/// watchOS provider that maps patterns to `WKHapticType`.
final class WatchHapticProvider: HapticProvider {
    
    /// watchOS devices support basic haptics.
    var supportsHaptics: Bool { true }

    /// No preparation required on watchOS.
    func prepare(_ pattern: HapticPattern) {}

    /// Plays the mapped watchOS haptic type.
    func play(_ pattern: HapticPattern) {
        guard let haptic = mappedHaptic(for: pattern) else { return }
        WKInterfaceDevice.current().play(haptic)
    }

    /// Maps library patterns to watchOS haptic types.
    private func mappedHaptic(for pattern: HapticPattern) -> WKHapticType? {
        switch pattern {
        case .impact:
            return .click
        case .notification(let type):
            switch type {
            case .success:
                return .success
            case .warning:
                return .retry
            case .error:
                return .failure
            }
        case .selection:
            return .click
        }
    }
}
#endif
