#if os(tvOS)
import Foundation

final class TVHapticProvider: HapticProvider {
    var supportsHaptics: Bool { false }
    func prepare(_ pattern: HapticPattern) {}
    func play(_ pattern: HapticPattern) {}
}
#endif
