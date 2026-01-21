import Foundation

@MainActor
public final class HapticEngine {
    
    public static let shared = HapticEngine()

    private let provider: HapticProvider

    public var supportsHaptics: Bool {
        provider.supportsHaptics
    }

    public init() {
        self.provider = HapticProviderFactory.makeDefault()
    }

    init(provider: HapticProvider) {
        self.provider = provider
    }

    public func prepare(_ pattern: HapticPattern) {
        provider.prepare(pattern)
    }

    public func play(_ pattern: HapticPattern) {
        provider.play(pattern)
    }
}
