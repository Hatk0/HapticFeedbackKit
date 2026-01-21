#if os(watchOS)
import WatchKit

final class WatchHapticProvider: HapticProvider {
    
    var supportsHaptics: Bool { true }

    func prepare(_ pattern: HapticPattern) {}

    func play(_ pattern: HapticPattern) {
        guard let haptic = mappedHaptic(for: pattern) else { return }
        WKInterfaceDevice.current().play(haptic)
    }

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
