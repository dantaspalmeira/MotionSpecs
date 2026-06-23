import Foundation

struct CodeGenerator {
    static func swiftUICode(for settings: MotionSettings) -> String {
        let response = settings.response.formatted(.number.precision(.fractionLength(2)))
        let damping = settings.damping.formatted(.number.precision(.fractionLength(2)))
        let stagger = settings.stagger.formatted(.number.precision(.fractionLength(2)))
        let scramble = settings.scramble.formatted(.number.precision(.fractionLength(2)))

        return """
        import SwiftUI

        enum MotionPreset: String {
            case cascade = "Cascade"
            case burst = "Burst"
            case drift = "Drift"
            case spiral = "Spiral"
            case snap = "Snap"
        }

        enum MotionCurve: String {
            case spring = "Spring"
            case ease = "Ease"
        }

        struct MotionSpec {
            var preset: MotionPreset = .\(settings.preset.rawValue.lowercased())
            var curve: MotionCurve = .\(settings.curve.rawValue.lowercased())
            var response: Double = \(response)
            var damping: Double = \(damping)
            var stagger: Double = \(stagger)
            var scramble: Double = \(scramble)

            func animation(for index: Int) -> Animation {
                let delay = Double(index) * stagger

                switch curve {
                case .spring:
                    return .spring(
                        response: response,
                        dampingFraction: damping,
                        blendDuration: 0.08
                    )
                    .delay(delay)
                case .ease:
                    return .easeInOut(duration: response * 1.15 + 0.16)
                        .delay(delay)
                }
            }
        }

        struct MotionCardStack<Content: View>: View {
            let spec = MotionSpec()
            let items = Array(0..<7)
            @State private var active = false
            let content: (Int) -> Content

            var body: some View {
                ZStack {
                    ForEach(items, id: \\.self) { index in
                        content(index)
                            .scaleEffect(active ? scale(for: index) : 0.72)
                            .rotationEffect(active ? rotation(for: index) : .degrees(-8))
                            .offset(active ? offset(for: index) : .zero)
                            .zIndex(Double(items.count - index))
                            .animation(spec.animation(for: index), value: active)
                    }
                }
                .onAppear { active = true }
            }

            private func offset(for index: Int) -> CGSize {
                let centered = Double(index) - Double(items.count - 1) / 2
                let noise = sin(Double(index + 1) * 12.9898) * spec.scramble

                switch spec.preset {
                case .cascade:
                    return CGSize(width: centered * 28 + noise * 22, height: centered * 22)
                case .burst:
                    let angle = Double(index) / Double(items.count) * .pi * 2
                    return CGSize(width: cos(angle) * 98, height: sin(angle) * 78)
                case .drift:
                    return CGSize(width: centered * 34 + noise * 36, height: sin(Double(index)) * 34)
                case .spiral:
                    let angle = Double(index) * 0.92
                    let radius = 22 + Double(index) * 17
                    return CGSize(width: cos(angle) * radius, height: sin(angle) * radius * 0.82)
                case .snap:
                    return CGSize(width: centered * 18, height: centered * 8)
                }
            }

            private func rotation(for index: Int) -> Angle {
                .degrees((Double(index) - 3) * 2.2 * max(spec.scramble, 0.2))
            }

            private func scale(for index: Int) -> CGFloat {
                1.0 - CGFloat(abs(Double(index) - 3.0)) * 0.025
            }
        }
        """
    }
}
