#if os(iOS)
import UIKit

@available(iOS 17.5, *)
@MainActor
public final class ApplePencilHaptics {
    
    private let generator: UICanvasFeedbackGenerator

    public init(view: UIView) {
        self.generator = UICanvasFeedbackGenerator(view: view)
    }

    public func prepare() {
        generator.prepare()
    }

    public func alignmentOccurred(at location: CGPoint) {
        generator.alignmentOccurred(at: location)
    }

    public func pathCompleted(at location: CGPoint) {
        generator.pathCompleted(at: location)
    }
}
#endif
