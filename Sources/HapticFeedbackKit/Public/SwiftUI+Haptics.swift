#if canImport(SwiftUI)
import Combine
import SwiftUI

public extension View {
    
    func hapticFeedback<T: Equatable>(_ pattern: HapticPattern, trigger: T) -> some View {
        modifier(HapticTriggerModifier(pattern: pattern, trigger: trigger))
    }
}

private struct HapticTriggerModifier<T: Equatable>: ViewModifier {
    let pattern: HapticPattern
    let trigger: T
    @State private var lastTrigger: T?

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
