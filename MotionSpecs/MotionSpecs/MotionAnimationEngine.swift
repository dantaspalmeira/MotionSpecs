import SwiftUI

struct MotionAnimationEngine {
    static func animation(for index: Int, settings: MotionSettings) -> Animation {
        let delay = Double(index) * settings.stagger

        switch settings.curve {
        case .spring:
            return .spring(
                response: settings.response,
                dampingFraction: settings.damping,
                blendDuration: 0.08
            )
            .delay(delay)
        case .ease:
            return .easeInOut(duration: settings.response * 1.15 + 0.16)
                .delay(delay)
        }
    }
}
