import SwiftUI

struct MotionSegmentedControl: View {
    @Binding var selection: MotionEditingMode

    var body: some View {
        HStack(spacing: 4) {
            ForEach(MotionEditingMode.allCases) { mode in
                Button {
                    selection = mode
                } label: {
                    Text(mode.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(selection == mode ? .black : .black.opacity(0.48))
                        .frame(maxWidth: .infinity)
                        .frame(height: 42)
                        .background {
                            if selection == mode {
                                RoundedRectangle(cornerRadius: 17, style: .continuous)
                                    .fill(.white)
                                    .shadow(color: .black.opacity(0.08), radius: 12, y: 5)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.055), in: RoundedRectangle(cornerRadius: 21, style: .continuous))
    }
}

struct MotionSegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        MotionSegmentedControl(selection: .constant(.position))
            .padding()
    }
}
