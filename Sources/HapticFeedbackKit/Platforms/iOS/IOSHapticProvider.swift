#if os(iOS)
import UIKit
#if canImport(CoreHaptics)
import CoreHaptics
#endif

final class IOSHapticProvider: HapticProvider {
    
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private var impactGenerators: [HapticPattern.ImpactStyle: UIImpactFeedbackGenerator] = [:]
#if canImport(CoreHaptics)
    private var coreHapticsEngine: CHHapticEngine?
#endif

    var supportsHaptics: Bool {
        #if canImport(CoreHaptics)
        return CHHapticEngine.capabilitiesForHardware().supportsHaptics
        #else
        return true
        #endif
    }

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
