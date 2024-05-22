import Foundation
import Presentation
import RxFlow
import Core

public class SignupFlow: Flow {

    public let container = FlowDI.shared
    public let rootViewController: EmailInputViewController

    public var root: Presentable {
        return rootViewController
    }

    public init() {
        rootViewController = EmailInputViewController(viewModel: container.emailInputViewModel)
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .emailInputIsRequired:
            return navigateToEmailInput()
        case .emailCheckIsRequired(let email):
            return navigateToEmailCheck(email: email)
        case .signupIsRequired(let email):
            return navigateToSignup(email: email)
        case .successSignup:
            return navigateToOnboarding()
        default:
            return .none
        }
    }
}

extension SignupFlow {
    private func navigateToEmailInput() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }
    private func navigateToEmailCheck(email: String) -> FlowContributors {
        let emailCheckViewController = EmailCheckViewController(viewModel: container.emailCheckViewModel)
        emailCheckViewController.email = email
        rootViewController.navigationController?.pushViewController(
            emailCheckViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: emailCheckViewController,
            withNextStepper: emailCheckViewController.viewModel))
    }
    private func navigateToSignup(email: String) -> FlowContributors {
        let signupViewController = SignupViewController(viewModel: container.signUpViewModel)
        signupViewController.email = email
        rootViewController.navigationController?.pushViewController(signupViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: signupViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }
    private func navigateToOnboarding() -> FlowContributors {
        rootViewController.navigationController?.popToRootViewController(animated: true)
        return .none
    }
}
