import SwiftUI

struct MotionCardTransform: Equatable {
    var offset: CGSize
    var scale: CGFloat
    var rotation: Angle
    var opacity: Double
    var zIndex: Double
}

struct MotionLayoutEngine {
    static func transform(
        for index: Int,
        total: Int,
        in size: CGSize,
        settings: MotionSettings,
        time: TimeInterval,
        isActive: Bool
    ) -> MotionCardTransform {
        let progress = isActive ? 1.0 : 0.0
        let centeredIndex = Double(index) - Double(total - 1) / 2.0
        let depth = 1.0 - abs(centeredIndex) / Double(max(total, 1))
        let scramble = settings.scramble
        let seed = Double(index + 1)
        let live = proceduralDrift(seed: seed, time: time, amount: settings.preset == .drift ? 1.0 : 0.28)
        let positionBias = settings.mode == .position ? 1.0 : 0.45
        let motionBias = settings.mode == .motion ? 1.0 : 0.55

        let final = finalOffset(
            for: index,
            total: total,
            size: size,
            preset: settings.preset,
            centeredIndex: centeredIndex,
            seed: seed,
            scramble: scramble,
            positionBias: positionBias,
            live: live
        )

        let origin = initialOffset(
            for: index,
            size: size,
            preset: settings.preset,
            finalOffset: final,
            seed: seed,
            scramble: scramble,
            motionBias: motionBias
        )

        let offset = CGSize(
            width: origin.width + (final.width - origin.width) * progress,
            height: origin.height + (final.height - origin.height) * progress
        )

        let finalRotation = rotation(
            for: index,
            preset: settings.preset,
            centeredIndex: centeredIndex,
            seed: seed,
            scramble: scramble,
            live: live
        )

        let originRotation = Angle.degrees(finalRotation.degrees * -0.35 + sin(seed) * 18.0)
        let rotation = Angle.degrees(originRotation.degrees + (finalRotation.degrees - originRotation.degrees) * progress)
        let scale = (0.7 + (0.3 + depth * 0.12) * progress).clamped(to: 0.68...1.08)

        return MotionCardTransform(
            offset: offset,
            scale: scale,
            rotation: rotation,
            opacity: 0.35 + 0.65 * progress,
            zIndex: zIndex(for: index, total: total, preset: settings.preset)
        )
    }

    private static func finalOffset(
        for index: Int,
        total: Int,
        size: CGSize,
        preset: MotionPreset,
        centeredIndex: Double,
        seed: Double,
        scramble: Double,
        positionBias: Double,
        live: CGPoint
    ) -> CGSize {
        let width = min(size.width, 390)
        let height = min(size.height, 520)
        let scrX = pseudo(seed, salt: 3) * 42.0 * scramble * positionBias
        let scrY = pseudo(seed, salt: 7) * 34.0 * scramble * positionBias

        switch preset {
        case .cascade:
            return CGSize(width: centeredIndex * 28 + scrX + live.x * 8, height: centeredIndex * 22 - 12 + scrY + live.y * 8)
        case .burst:
            let angle = (Double(index) / Double(total)) * .pi * 2.0 + scramble * 0.65
            let radius = min(width, height) * (0.18 + 0.12 * abs(centeredIndex) / Double(total))
            return CGSize(width: cos(angle) * radius + scrX, height: sin(angle) * radius * 0.82 + scrY - 12)
        case .drift:
            return CGSize(width: centeredIndex * 34 + live.x * 26 + scrX, height: sin(seed * 1.72) * 34 + live.y * 28 + scrY - 8)
        case .spiral:
            let angle = Double(index) * 0.92 + scramble * 1.1
            let radius = 22.0 + Double(index) * 17.0
            return CGSize(width: cos(angle) * radius + scrX, height: sin(angle) * radius * 0.82 + scrY - 8)
        case .snap:
            return CGSize(width: centeredIndex * 18 + scrX * 0.35, height: centeredIndex * 8 + scrY * 0.25 - 6)
        }
    }

    private static func initialOffset(
        for index: Int,
        size: CGSize,
        preset: MotionPreset,
        finalOffset: CGSize,
        seed: Double,
        scramble: Double,
        motionBias: Double
    ) -> CGSize {
        switch preset {
        case .cascade:
            return CGSize(width: finalOffset.width - 72 - seed * 5, height: finalOffset.height + 88)
        case .burst:
            return CGSize(width: 0, height: 2)
        case .drift:
            return CGSize(width: finalOffset.width + pseudo(seed, salt: 11) * 80 * motionBias, height: finalOffset.height + pseudo(seed, salt: 13) * 54 * motionBias)
        case .spiral:
            return CGSize(width: finalOffset.width * 0.28, height: finalOffset.height * 0.28)
        case .snap:
            return CGSize(width: finalOffset.width + pseudo(seed, salt: 17) * 46 * (1.0 + scramble), height: finalOffset.height - 36 * motionBias)
        }
    }

    private static func rotation(
        for index: Int,
        preset: MotionPreset,
        centeredIndex: Double,
        seed: Double,
        scramble: Double,
        live: CGPoint
    ) -> Angle {
        let noise = pseudo(seed, salt: 23) * 8.0 * scramble

        switch preset {
        case .cascade:
            return .degrees(centeredIndex * 2.3 + noise)
        case .burst:
            return .degrees(pseudo(seed, salt: 29) * 10.0 + noise)
        case .drift:
            return .degrees(live.x * 2.8 + centeredIndex * 1.8 + noise)
        case .spiral:
            return .degrees(Double(index) * 4.6 + noise)
        case .snap:
            return .degrees(centeredIndex * 0.9 + noise * 0.35)
        }
    }

    private static func zIndex(for index: Int, total: Int, preset: MotionPreset) -> Double {
        switch preset {
        case .burst, .spiral:
            return Double(index)
        default:
            return Double(total - index)
        }
    }

    private static func proceduralDrift(seed: Double, time: TimeInterval, amount: Double) -> CGPoint {
        CGPoint(
            x: sin(time * 0.72 + seed * 1.31) * amount,
            y: cos(time * 0.58 + seed * 0.97) * amount
        )
    }

    private static func pseudo(_ seed: Double, salt: Double) -> Double {
        let value = sin(seed * 12.9898 + salt * 78.233) * 43758.5453
        return (value - floor(value)) * 2.0 - 1.0
    }
}

private extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
