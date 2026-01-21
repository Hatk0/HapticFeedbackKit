import Foundation

/// Creates the default provider for the current platform.
enum HapticProviderFactory {
    /// Returns a provider matching the active OS.
    static func makeDefault() -> HapticProvider {
        #if os(iOS)
        return IOSHapticProvider()
        #elseif os(watchOS)
        return WatchHapticProvider()
        #elseif os(macOS)
        return MacHapticProvider()
        #elseif os(tvOS)
        return TVHapticProvider()
        #else
        return NoopHapticProvider()
        #endif
    }
}
