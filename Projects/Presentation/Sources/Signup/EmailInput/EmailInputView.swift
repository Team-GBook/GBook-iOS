import SwiftUI
import xquare_design_system_iOS

public struct EmailInputView: View {
    @State var text: String = ""
    @Environment(\.dismiss) var dismiss: DismissAction
    @EnvironmentObject var sceneState: SceneState

    public init () { }
    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            Text("이메일 인증")
                .xFont(.headline(.large), weight: .bold)
                .padding(.leading, 16)
            XTextField("이메일", text: $text)
                .padding(.horizontal, 16)
            Spacer()
            NavigationLink(
                destination: EmailCertificationView().environmentObject(sceneState),
                label: {
                GBButton(title: "인증번호 전송") {
                }
            })
 
        }
        .xBackButton(dismiss: dismiss)
    }
}
