import SwiftUI

struct PresetTabBar: View {
    @Binding var selection: MotionPreset

    var body: some View {
        HStack(spacing: 3) {
            ForEach(MotionPreset.allCases) { preset in
                Button {
                    selection = preset
                } label: {
                    Text(preset.rawValue)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(selection == preset ? .white : .black.opacity(0.55))
                        .lineLimit(1)
                        .minimumScaleFactor(0.66)
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .contentShape(Capsule())
                        .background {
                            if selection == preset {
                                Capsule()
                                    .fill(.black)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(3)
        .background(.white.opacity(0.66), in: Capsule())
    }
}

struct PresetTabBar_Previews: PreviewProvider {
    static var previews: some View {
        PresetTabBar(selection: .constant(.cascade))
            .padding()
    }
}
