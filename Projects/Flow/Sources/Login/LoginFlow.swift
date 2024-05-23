import Foundation
import Presentation
import RxFlow
import Core

public class LoginFlow: Flow {

    private let container = FlowDI.shared
    public let rootViewController: LoginViewController

    public var root: Presentable {
        return rootViewController
    }

    public init(rootViewController: LoginViewController) {
        self.rootViewController = LoginViewController(viewModel: container.loginViewModel)
    }
    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .loginIsRequired:
            return navigateToLogin()
        case .homeIsRequired:
            return navigateToHome()
        default:
            return .none
        }
    }
}

extension LoginFlow {

    private func navigateToLogin() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: container.loginViewModel
        ))
    }
    private func navigateToHome() -> FlowContributors {
//        print("loginSuccess")
        return .end(forwardToParentFlowWithStep: AppStep.homeIsRequired)
    }
}
