import Foundation

final class NoopHapticProvider: HapticProvider {
    
    var supportsHaptics: Bool { false }
    
    func prepare(_ pattern: HapticPattern) {}
    func play(_ pattern: HapticPattern) {}
}
