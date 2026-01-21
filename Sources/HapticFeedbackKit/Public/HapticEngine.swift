import Foundation

/// Public facade that routes haptic requests to the active platform provider.
@MainActor
public final class HapticEngine {
    
    /// Shared singleton instance for simple usage.
    public static let shared = HapticEngine()

    private let provider: HapticProvider

    /// Indicates if the current platform can produce haptics.
    public var supportsHaptics: Bool {
        provider.supportsHaptics
    }

    /// Creates the engine with a default platform provider.
    public init() {
        self.provider = HapticProviderFactory.makeDefault()
    }

    /// Creates the engine with a custom provider (useful for tests).
    init(provider: HapticProvider) {
        self.provider = provider
    }

    /// Prepares resources for the given pattern when supported by the platform.
    public func prepare(_ pattern: HapticPattern) {
        provider.prepare(pattern)
    }

    /// Plays the given haptic pattern.
    public func play(_ pattern: HapticPattern) {
        provider.play(pattern)
    }
}
