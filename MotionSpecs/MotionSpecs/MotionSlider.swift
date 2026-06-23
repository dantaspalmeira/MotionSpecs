import SwiftUI

struct MotionSlider: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>

    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.black.opacity(0.62))
                .frame(width: 66, alignment: .leading)

            Slider(value: $value, in: range)
                .tint(.black)
                .frame(height: 38)

            Text(value.formatted(.number.precision(.fractionLength(2))))
                .font(.system(.caption, design: .monospaced, weight: .semibold))
                .foregroundStyle(.black.opacity(0.62))
                .frame(width: 36, alignment: .trailing)
        }
        .frame(height: 38)
    }
}

struct MotionSlider_Previews: PreviewProvider {
    static var previews: some View {
        MotionSlider(title: "Response", value: .constant(0.56), range: 0...1)
            .padding()
    }
}
