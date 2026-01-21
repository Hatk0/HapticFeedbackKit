# HapticFeedbackKit

Unified haptic feedback API for iOS, iPadOS, watchOS, macOS, and tvOS with UIKit and SwiftUI helpers.

## Features
- Single `HapticEngine` API across platforms
- Built-in patterns: impact, notification, selection
- Custom Core Haptics support on iOS/iPadOS
- SwiftUI helper for trigger-based feedback

## Requirements
- Swift 5.9
- iOS 13+
- iPadOS 13+
- watchOS 6+
- macOS 10.15+
- tvOS 13+

## Installation (Swift Package Manager)
Add the package to your project or `Package.swift`:

```swift
.package(url: "https://github.com/your-org/HapticFeedbackKit", from: "0.1.0")
```

## Usage

### UIKit / AppKit / watchOS
```swift
HapticEngine.shared.play(.impact(.medium))
HapticEngine.shared.play(.notification(.success))
HapticEngine.shared.play(.selection)
```

### SwiftUI
```swift
struct ContentView: View {
    @State private var counter = 0

    var body: some View {
        Button("Tap") { counter += 1 }
            .hapticFeedback(.impact(.light), trigger: counter)
    }
}
```

### Custom Core Haptics (iOS/iPadOS)
```swift
import CoreHaptics

let events: [CHHapticEvent] = [
    CHHapticEvent(eventType: .hapticTransient,
                  parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)],
                  relativeTime: 0)
]

let pattern = try CHHapticPattern(events: events, parameters: [])
HapticEngine.shared.play(.custom(CustomHapticPattern(pattern)))
```

## Platform behavior
- iOS/iPadOS: UIKit generators and Core Haptics for custom patterns
- watchOS: mapped to `WKHapticType`
- macOS: `NSHapticFeedbackManager`
- tvOS: no-op (no system haptics API)

## Extensibility
Add new patterns by extending `HapticPattern` and mapping in each platform provider.

## License
MIT (or your license here)
