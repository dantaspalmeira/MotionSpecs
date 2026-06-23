import SwiftUI

struct CodeSheetView: View {
    let settings: MotionSettings

    @Environment(\.dismiss) private var dismiss
    @State private var didCopy = false

    private var code: String {
        CodeGenerator.swiftUICode(for: settings)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    Text(code)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                }
                .background(Color.black.opacity(0.045))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(16)

                Button {
                    ClipboardManager.copy(code)
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
                        didCopy = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            didCopy = false
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: didCopy ? "checkmark" : "doc.on.doc")
                        Text(didCopy ? "Copied" : "Copy")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.black, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .navigationTitle("SwiftUI Code")
            .codeSheetNavigationStyle()
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                #else
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                }
                #endif
            }
        }
    }
}

private extension View {
    @ViewBuilder
    func codeSheetNavigationStyle() -> some View {
        #if os(iOS)
        navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }
}

struct CodeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CodeSheetView(settings: MotionSettings())
    }
}
