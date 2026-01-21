import Foundation

protocol HapticProvider {
    var supportsHaptics: Bool { get }
    func prepare(_ pattern: HapticPattern)
    func play(_ pattern: HapticPattern)
}
