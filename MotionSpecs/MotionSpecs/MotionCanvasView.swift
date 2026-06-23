import SwiftUI

struct MotionCanvasView: View {
    let settings: MotionSettings
    let revision: Int

    @State private var isActive = false

    private let cardCount = 7

    var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation) { timeline in
                ZStack {
                    ForEach(0..<cardCount, id: \.self) { index in
                        let transform = MotionLayoutEngine.transform(
                            for: index,
                            total: cardCount,
                            in: proxy.size,
                            settings: settings,
                            time: timeline.date.timeIntervalSinceReferenceDate,
                            isActive: isActive
                        )

                        ImageCardView(index: index, isPrimary: index == 3)
                            .frame(width: index == 3 ? 176 : 136, height: index == 3 ? 226 : 176)
                            .scaleEffect(transform.scale)
                            .rotationEffect(transform.rotation)
                            .offset(transform.offset)
                            .opacity(transform.opacity)
                            .zIndex(index == 3 ? 100 : transform.zIndex)
                            .animation(MotionAnimationEngine.animation(for: index, settings: settings), value: isActive)
                            .animation(MotionAnimationEngine.animation(for: index, settings: settings), value: settings)
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .onAppear {
            runEntrance()
        }
        .onChange(of: revision) { _, _ in
            runEntrance()
        }
    }

    private func runEntrance() {
        isActive = false
        DispatchQueue.main.async {
            isActive = true
        }
    }
}

struct MotionCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        MotionCanvasView(settings: MotionSettings(), revision: 0)
    }
}
