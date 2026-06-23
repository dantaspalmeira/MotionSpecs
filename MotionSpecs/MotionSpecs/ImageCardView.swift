import SwiftUI

struct ImageCardView: View {
    let index: Int
    let isPrimary: Bool

    private var palette: CardPalette {
        CardPalette.palettes[index % CardPalette.palettes.count]
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: isPrimary ? 26 : 22, style: .continuous)
                .fill(.white)

            Canvas { context, size in
                let base = Path(CGRect(origin: .zero, size: size))
                context.fill(base, with: .linearGradient(
                    Gradient(colors: palette.colors),
                    startPoint: CGPoint(x: 0, y: 0),
                    endPoint: CGPoint(x: size.width, y: size.height)
                ))

                for mark in 0..<5 {
                    let rect = CGRect(
                        x: size.width * CGFloat(0.08 + Double(mark) * 0.16),
                        y: size.height * CGFloat(0.10 + Double((mark + index) % 3) * 0.18),
                        width: size.width * CGFloat(0.32 + Double(mark % 2) * 0.18),
                        height: size.height * CGFloat(0.26 + Double((mark + 1) % 2) * 0.12)
                    )
                    let path = Path(roundedRect: rect, cornerRadius: 18)
                    context.fill(path, with: .color(.white.opacity(mark == 2 ? 0.28 : 0.16)))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: isPrimary ? 22 : 18, style: .continuous))
            .padding(isPrimary ? 10 : 8)

            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.white.opacity(0.78))
                            .frame(width: isPrimary ? 64 : 48, height: 6)
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.white.opacity(0.42))
                            .frame(width: isPrimary ? 42 : 32, height: 5)
                    }
                    Spacer()
                }
                .padding(isPrimary ? 22 : 18)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: isPrimary ? 26 : 22, style: .continuous)
                .stroke(.white.opacity(0.78), lineWidth: 1)
        }
        .shadow(color: .black.opacity(isPrimary ? 0.18 : 0.12), radius: isPrimary ? 28 : 20, y: isPrimary ? 18 : 12)
    }
}

private struct CardPalette {
    let colors: [Color]

    static let palettes: [CardPalette] = [
        CardPalette(colors: [Color(hex: 0x111827), Color(hex: 0xD9B88F), Color(hex: 0xF6F2EB)]),
        CardPalette(colors: [Color(hex: 0xB7D8C9), Color(hex: 0xFBF1D4), Color(hex: 0xE6735F)]),
        CardPalette(colors: [Color(hex: 0x1A365D), Color(hex: 0xE7C37E), Color(hex: 0xF8FAFC)]),
        CardPalette(colors: [Color(hex: 0xEDE9FE), Color(hex: 0x2F4858), Color(hex: 0xF97316)]),
        CardPalette(colors: [Color(hex: 0xC7D2FE), Color(hex: 0xFDE68A), Color(hex: 0x0F172A)]),
        CardPalette(colors: [Color(hex: 0xF8C8DC), Color(hex: 0x9AD0C2), Color(hex: 0xFFFFFF)]),
        CardPalette(colors: [Color(hex: 0xDEE2E6), Color(hex: 0x495057), Color(hex: 0xFCA311)])
    ]
}

private extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView(index: 3, isPrimary: true)
            .frame(width: 176, height: 226)
            .padding()
    }
}
