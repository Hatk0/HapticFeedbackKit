#if canImport(SwiftUI)
import Combine
import SwiftUI

/// Adds trigger-based haptic feedback to a view.
public extension View {
    
    /// Plays a pattern when the trigger value changes.
    func hapticFeedback<T: Equatable>(_ pattern: HapticPattern, trigger: T) -> some View {
        modifier(HapticTriggerModifier(pattern: pattern, trigger: trigger))
    }
}

/// Internal modifier that detects trigger changes and plays haptics.
private struct HapticTriggerModifier<T: Equatable>: ViewModifier {
    let pattern: HapticPattern
    let trigger: T
    @State private var lastTrigger: T?

    /// Evaluates the trigger value and plays haptics when it changes.
    func body(content: Content) -> some View {
        content
            .onAppear { lastTrigger = trigger }
            .onReceive(Just(trigger)) { value in
                guard lastTrigger != value else { return }
                lastTrigger = value
                HapticEngine.shared.play(pattern)
            }
    }
}
#endif
