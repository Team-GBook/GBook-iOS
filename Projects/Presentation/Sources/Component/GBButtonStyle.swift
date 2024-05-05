import SwiftUI
import xquare_design_system_iOS

struct GBButtonStyle: ButtonStyle {
    var style: Style

    enum Style {
        case common
    }

    init(style: Style) {
        self.style = style
    }
    func makeBody(configuration: Configuration) -> some View {
        return AnyView(KGButton(configuration: configuration, isEditing: false))
    }

    
    
    struct KGButton: View {
        let configuration: ButtonStyle.Configuration
        let isEditing: Bool
        @Environment(\.isEnabled) private var isEnabled: Bool

        var body: some View {
            configuration.label
                .xFont(.body(.medium))
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.Secondary.secondary)
                .cornerRadius(10)

        }
    }
}

extension Button {
    func style(_ style: GBButtonStyle.Style) -> some View {
        self.buttonStyle(GBButtonStyle(style: style))
    }
}

