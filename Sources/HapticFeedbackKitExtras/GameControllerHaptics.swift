#if canImport(GameController)
import Foundation
import GameController
import CoreHaptics

public enum GameControllerHaptics {
    @available(iOS 14.0, tvOS 14.0, macOS 11.0, *)
    public static func makeEngine(haptics: GCDeviceHaptics, locality: GCHapticsLocality = .default) -> CHHapticEngine? {
        haptics.createEngine(withLocality: locality)
    }

    @available(iOS 14.0, tvOS 14.0, macOS 11.0, *)
    public static func makeEngine(for controller: GCController, locality: GCHapticsLocality = .default) -> CHHapticEngine? {
        guard let haptics = controller.haptics else { return nil }
        return makeEngine(haptics: haptics, locality: locality)
    }

}
#endif
