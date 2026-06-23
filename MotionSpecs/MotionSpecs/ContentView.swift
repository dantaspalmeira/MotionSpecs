import SwiftUI

struct ContentView: View {
    @State private var settings = MotionSettings()
    @State private var animationRevision = 0
    @State private var isShowingCode = false

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.white
                    .ignoresSafeArea()

                MotionCanvasView(settings: settings, revision: animationRevision)
                    .frame(
                        width: proxy.size.width,
                        height: max(proxy.size.height - 280, 360)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 54)

                topBar

                MotionControlPanel(settings: $settings)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)

                floatingActions
            }
        }
        .onChange(of: settings.preset) { _, _ in
            animationRevision += 1
        }
        .onChange(of: settings.mode) { _, _ in
            animationRevision += 1
        }
        .onChange(of: settings.curve) { _, _ in
            animationRevision += 1
        }
        .sheet(isPresented: $isShowingCode) {
            CodeSheetView(settings: settings)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    private var topBar: some View {
        VStack {
            HStack {
                Button {
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 18, y: 8)
                }
                .accessibilityLabel("Back")

                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.top, 8)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var floatingActions: some View {
        VStack(spacing: 12) {
            FloatingActionButton(systemName: "slider.horizontal.3") {
                settings.mode = settings.mode == .position ? .motion : .position
            }
            .accessibilityLabel("Adjust")

            FloatingActionButton(systemName: "chevron.left.forwardslash.chevron.right") {
                isShowingCode = true
            }
            .accessibilityLabel("Generate code")
        }
        .padding(.trailing, 22)
        .padding(.bottom, 382)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
