#if os(iOS)
import UIKit
#if canImport(CoreHaptics)
import CoreHaptics
#endif

/// iOS/iPadOS provider backed by UIKit feedback generators and Core Haptics.
final class IOSHapticProvider: HapticProvider {
    
    /// Selection feedback generator reused across plays.
    private let selectionGenerator = UISelectionFeedbackGenerator()
    /// Notification feedback generator reused across plays.
    private let notificationGenerator = UINotificationFeedbackGenerator()
    /// Cached impact generators by style.
    private var impactGenerators: [HapticPattern.ImpactStyle: UIImpactFeedbackGenerator] = [:]
#if canImport(CoreHaptics)
    /// Lazily created Core Haptics engine for custom patterns.
    private var coreHapticsEngine: CHHapticEngine?
#endif

    /// Indicates whether Core Haptics is supported on this device.
    var supportsHaptics: Bool {
        #if canImport(CoreHaptics)
        return CHHapticEngine.capabilitiesForHardware().supportsHaptics
        #else
        return true
        #endif
    }

    /// Prepares generators or Core Haptics depending on the pattern.
    func prepare(_ pattern: HapticPattern) {
        switch pattern {
        case .impact(let style):
            impactGenerator(for: style).prepare()
        case .notification:
            notificationGenerator.prepare()
        case .selection:
            selectionGenerator.prepare()
#if canImport(CoreHaptics)
        case .custom:
            prepareCustom()
#endif
        }
    }

    /// Plays the requested haptic pattern.
    func play(_ pattern: HapticPattern) {
        switch pattern {
        case .impact(let style):
            impactGenerator(for: style).impactOccurred()
        case .notification(let type):
            notificationGenerator.notificationOccurred(notificationType(for: type))
        case .selection:
            selectionGenerator.selectionChanged()
#if canImport(CoreHaptics)
        case .custom(let custom):
            playCustom(custom)
#endif
        }
    }

    /// Returns a cached impact generator for the requested style.
    private func impactGenerator(for style: HapticPattern.ImpactStyle) -> UIImpactFeedbackGenerator {
        if let generator = impactGenerators[style] {
            return generator
        }

        let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
        switch style {
        case .light:
            feedbackStyle = .light
        case .medium:
            feedbackStyle = .medium
        case .heavy:
            feedbackStyle = .heavy
        case .soft:
            feedbackStyle = .soft
        case .rigid:
            feedbackStyle = .rigid
        }

        let generator = UIImpactFeedbackGenerator(style: feedbackStyle)
        impactGenerators[style] = generator
        return generator
    }

    /// Maps library notification types to UIKit types.
    private func notificationType(for type: HapticPattern.NotificationType) -> UINotificationFeedbackGenerator.FeedbackType {
        switch type {
        case .success:
            return .success
        case .warning:
            return .warning
        case .error:
            return .error
        }
    }

#if canImport(CoreHaptics)
    /// Starts the Core Haptics engine for custom patterns.
    private func prepareCustom() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            if coreHapticsEngine == nil {
                coreHapticsEngine = try CHHapticEngine()
            }
            try coreHapticsEngine?.start()
        } catch {
            HapticLogger.error("Core Haptics prepare failed: \(error)")
        }
    }

    /// Plays a Core Haptics pattern using the engine.
    private func playCustom(_ custom: CustomHapticPattern) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            if coreHapticsEngine == nil {
                coreHapticsEngine = try CHHapticEngine()
            }
            if coreHapticsEngine?.isRunning == false {
                try coreHapticsEngine?.start()
            }
            let player = try coreHapticsEngine?.makePlayer(with: custom.pattern)
            try player?.start(atTime: 0)
        } catch {
            HapticLogger.error("Core Haptics play failed: \(error)")
        }
    }
#endif
}
#endif
