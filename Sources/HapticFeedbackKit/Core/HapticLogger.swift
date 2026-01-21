import Foundation
#if canImport(os)
import os
#endif

/// Internal logging helper for haptics failures.
enum HapticLogger {
    /// Logs an error message using unified logging when available.
    static func error(_ message: String) {
        #if canImport(os)
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            let logger = Logger(subsystem: "HapticFeedbackKit", category: "Haptics")
            logger.error("\(message, privacy: .public)")
        } else {
            let log = OSLog(subsystem: "HapticFeedbackKit", category: "Haptics")
            os_log("%{public}@", log: log, type: .error, message)
        }
        #else
        print("HapticFeedbackKit error: \(message)")
        #endif
    }
}
