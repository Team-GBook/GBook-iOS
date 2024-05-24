import Foundation
import Presentation
import RxFlow
import Core

public class OnboardingFlow: Flow {

    private let container = FlowDI.shared
    private let rootViewController = BaseNavigationController()

    public var root: Presentable {
        return rootViewController
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .onboardingIsRequired:
            return navigateToOnboarding()
        case .loginIsRequired:
            return navigateToLogin()
        case .emailInputIsRequired:
            return navigateToEmailInput()
        case .homeIsRequired:
            return presentHome()
        default:
            return .none
        }
    }
}

extension OnboardingFlow {

    private func navigateToOnboarding() -> FlowContributors {

        let onboardingViewController = OnboardingViewController(viewModel: container.onboardingViewModel)
        self.rootViewController.setViewControllers(
            [onboardingViewController],
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: onboardingViewController,
            withNextStepper: onboardingViewController.viewModel
        ))
    }
    private func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow(rootViewController: LoginViewController(viewModel: container.loginViewModel))
        Flows.use(
            loginFlow,
            when: .created
        ) { root in
            self.rootViewController.pushViewController(
                root,
                animated: true
            )
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: loginFlow,
            withNextStepper: OneStepper(withSingleStep: AppStep.loginIsRequired)))
    }
    private func navigateToEmailInput() -> FlowContributors {
        let signupFlow = SignupFlow()
        Flows.use(
            signupFlow,
            when: .created
        ) { root in
                self.rootViewController.pushViewController(
                    root,
                    animated: true
                )
            }
        return .one(flowContributor: .contribute(
            withNextPresentable: signupFlow,
            withNextStepper: OneStepper(withSingleStep: AppStep.emailInputIsRequired))
        )
    }
    private func presentHome() -> FlowContributors {
        return .end(forwardToParentFlowWithStep: AppStep.homeIsRequired)
//        let homeFlow = HomeFlow(rootViewController: HomeViewController(viewModel: container.homeViewModel))
//        Flows.use(
//            homeFlow,
//            when: .created
//        ) { root in
//                self.rootViewController.setViewControllers(
//                    [root],
//                    animated: true
//                )
//            
//            }
//        return .one(flowContributor: .contribute(
//            withNextPresentable: homeFlow,
//            withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)
//            )
//        )
//        return .end(forwardToParentFlowWithStep: AppStep.homeIsRequired)
    }
}
