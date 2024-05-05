import SwiftUI
import xquare_design_system_iOS
import Core
import Domain
import Data

public struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @State private var isLoginActive: Bool = false
    @Environment(\.dismiss) var dismiss: DismissAction
    @EnvironmentObject var sceneState: SceneState

    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            Text("로그인")
                .xFont(.headline(.large), weight: .bold)
                .padding(.leading, 20)
            Group {
                XTextField(
                    "이메일",
                    text: $viewModel.email
                )
                XTextField(
                    "비밀번호",
                    text: $viewModel.password
                )
            }
            .padding(.horizontal, 20)
            Spacer()
            GBButton(title: "로그인") {
                viewModel.login()
            }
            .onChange(of: viewModel.isLoginSuccess, perform: { isSuccess in
                if isSuccess {
                    sceneState.scene = .main
                }
            })
            .xBackButton(dismiss: dismiss)
        }
    }
}
