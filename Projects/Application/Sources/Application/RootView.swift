import SwiftUI
import Presentation
import Data

struct RootView: View {
    @EnvironmentObject var sceneState: SceneState
    let authDI = AuthDI.shared
    let onboardingView: OnboardingView
    let loginView: LoginView
    let mainView: MainView


    init() {
        let loginViewModel = LoginViewModel(loginUseCase: authDI.loginUseCase)
        self.loginView = LoginView(viewModel: loginViewModel)
        self.onboardingView = OnboardingView(viewModel: loginViewModel)
        self.mainView = MainView()
    }

    var body: some View {
        switch sceneState.scene {
        case .onboarding:
            onboardingView
                .environmentObject(sceneState)

        case .login:
            loginView
                .environmentObject(sceneState)

        case .main:
            mainView
                .environmentObject(sceneState)
        case .emailCertification:
            EmailCertificationView()

        default:
            loginView
                .environmentObject(sceneState)

        }
    }
}
