#if os(iOS)
import UIKit

/// Wrapper around `UICanvasFeedbackGenerator` for Apple Pencil Pro haptics.
@available(iOS 17.5, *)
@MainActor
public final class ApplePencilHaptics {
    
    /// The underlying UIKit feedback generator.
    private let generator: UICanvasFeedbackGenerator

    /// Creates a generator bound to a canvas view.
    public init(view: UIView) {
        self.generator = UICanvasFeedbackGenerator(view: view)
    }

    /// Prepares the generator for imminent playback.
    public func prepare() {
        generator.prepare()
    }

    /// Plays an alignment feedback at a view location.
    public func alignmentOccurred(at location: CGPoint) {
        generator.alignmentOccurred(at: location)
    }

    /// Plays a path-completion feedback at a view location.
    public func pathCompleted(at location: CGPoint) {
        generator.pathCompleted(at: location)
    }
}
#endif
