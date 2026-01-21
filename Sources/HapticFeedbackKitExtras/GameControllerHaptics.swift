#if canImport(GameController)
import Foundation
import GameController
import CoreHaptics

/// Helpers for creating Core Haptics engines targeting controller haptics.
public enum GameControllerHaptics {
    /// Creates a `CHHapticEngine` for the given device haptics profile.
    @available(iOS 14.0, tvOS 14.0, macOS 11.0, *)
    public static func makeEngine(haptics: GCDeviceHaptics, locality: GCHapticsLocality = .default) -> CHHapticEngine? {
        haptics.createEngine(withLocality: locality)
    }

    /// Creates a `CHHapticEngine` for a controller's haptics profile.
    @available(iOS 14.0, tvOS 14.0, macOS 11.0, *)
    public static func makeEngine(for controller: GCController, locality: GCHapticsLocality = .default) -> CHHapticEngine? {
        guard let haptics = controller.haptics else { return nil }
        return makeEngine(haptics: haptics, locality: locality)
    }
}
#endif
