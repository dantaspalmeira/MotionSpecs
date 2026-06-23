import SwiftUI

enum MotionPreset: String, CaseIterable, Identifiable {
    case cascade = "Cascade"
    case burst = "Burst"
    case drift = "Drift"
    case spiral = "Spiral"
    case snap = "Snap"

    var id: String { rawValue }
}

enum MotionCurve: String, CaseIterable, Identifiable {
    case spring = "Spring"
    case ease = "Ease"

    var id: String { rawValue }
}

enum MotionEditingMode: String, CaseIterable, Identifiable {
    case position = "Position"
    case motion = "Motion"

    var id: String { rawValue }
}
