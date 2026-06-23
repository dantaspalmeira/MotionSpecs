#if canImport(UIKit)
import UIKit
#endif

struct ClipboardManager {
    static func copy(_ text: String) {
        #if canImport(UIKit)
        UIPasteboard.general.string = text
        #endif
    }
}
