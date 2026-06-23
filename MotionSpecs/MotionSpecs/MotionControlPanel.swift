import SwiftUI

struct MotionControlPanel: View {
    @Binding var settings: MotionSettings

    var body: some View {
        VStack(spacing: 14) {
            PresetTabBar(selection: $settings.preset)

            MotionSegmentedControl(selection: $settings.mode)

            curveControl

            VStack(spacing: 10) {
                MotionSlider(title: "Response", value: $settings.response, range: 0.18...1.2)
                MotionSlider(title: "Damping", value: $settings.damping, range: 0.42...0.98)
                MotionSlider(title: "Stagger", value: $settings.stagger, range: 0.0...0.16)
                MotionSlider(title: "Scramble", value: $settings.scramble, range: 0.0...1.0)
            }
        }
        .padding(.horizontal, 14)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white.opacity(0.38))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(.white.opacity(0.76), lineWidth: 1)
                }
        }
        .shadow(color: .black.opacity(0.12), radius: 28, y: 16)
    }

    private var curveControl: some View {
        HStack(spacing: 10) {
            Text("Curve")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.black.opacity(0.62))
                .frame(width: 66, alignment: .leading)

            HStack(spacing: 4) {
                ForEach(MotionCurve.allCases) { curve in
                    Button {
                        settings.curve = curve
                    } label: {
                        Text(curve.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(settings.curve == curve ? .white : .black.opacity(0.58))
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .background {
                                if settings.curve == curve {
                                    Capsule()
                                        .fill(.black)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(4)
            .background(.white.opacity(0.62), in: Capsule())
        }
    }
}

struct MotionControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        MotionControlPanel(settings: .constant(MotionSettings()))
            .padding()
            .background(Color.white)
    }
}
