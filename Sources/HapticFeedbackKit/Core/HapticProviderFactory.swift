import Foundation

enum HapticProviderFactory {
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
