import SwiftUI

// DesignSystem으로 빼기
struct GBButton: View {
    var title: String?
    let style: GBButtonStyle.Style
    let action: () -> ()

    init(
        title: String? = nil,
        style: GBButtonStyle.Style = .common,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
    var body: some View {
        Button(action: action) {
            Text(title ?? "")
                .multilineTextAlignment(.center)
        }
        .style(style)
        .padding(.horizontal, 24)
    }
}
