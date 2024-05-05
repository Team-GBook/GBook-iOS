import SwiftUI
import xquare_design_system_iOS

public struct OnboardingView: View {
    @StateObject var viewModel: LoginViewModel
    @State private var isShowingLoginView = false
    @EnvironmentObject var sceneState: SceneState

    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        VStack {
            Spacer()
            Image("logo")
            Spacer()
            VStack(spacing: 12) {
                NavigationLink(
                    destination: 
                        LoginView(viewModel: viewModel)
                            .environmentObject(sceneState),
                    isActive: $isShowingLoginView,
                    label: {
                        GBButton(title: "로그인하기") {
                            isShowingLoginView = true
                        }
                    })
                NavigationLink(
                    destination: EmailInputView()
                        .environmentObject(sceneState)
                ) {
                    Text("아이디가 아직 없으신가요?")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.Secondary.secondary)
                }
            }
        }
    }
}
