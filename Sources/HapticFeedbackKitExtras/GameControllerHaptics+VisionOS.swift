#if os(visionOS)
import GameController
import CoreHaptics

/// visionOS additions for stylus-backed haptics.
public extension GameControllerHaptics {
    
    /// Creates a `CHHapticEngine` for a stylus haptics profile.
    @available(visionOS 26.0, *)
    static func makeEngine(for stylus: GCStylus, locality: GCHapticsLocality = .default) -> CHHapticEngine? {
        guard let haptics = stylus.haptics else { return nil }
        return makeEngine(haptics: haptics, locality: locality)
    }
}
#endif
