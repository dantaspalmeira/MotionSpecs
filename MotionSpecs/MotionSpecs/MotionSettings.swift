import Foundation

struct MotionSettings: Equatable {
    var preset: MotionPreset = .cascade
    var mode: MotionEditingMode = .position
    var curve: MotionCurve = .spring
    var response: Double = 0.56
    var damping: Double = 0.74
    var stagger: Double = 0.08
    var scramble: Double = 0.34
}
