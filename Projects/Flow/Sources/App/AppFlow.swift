import RxFlow
import UIKit
import Presentation
import Core

public class AppFlow: Flow {

    private let window: UIWindow
    private let container = FlowDI.shared

    public var root: RxFlow.Presentable {
        return window
    }

    public init(window: UIWindow) {
        self.window = window
    }
    
    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .onboardingIsRequired:
            return navigateToOnboarding()
        case .homeIsRequired:
            return navigateToHome()
        case .testIsRequired:
            return navigateTest()
        default:
            return .none
        }
    }
}

extension AppFlow {
    private func navigateToOnboarding() -> FlowContributors {
        let onboardingFlow = OnboardingFlow()
        Flows.use(onboardingFlow, when: .created) { root in
            self.window.rootViewController = root
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: onboardingFlow,
                withNextStepper: OneStepper(withSingleStep: AppStep.onboardingIsRequired)
            )
        )
    }
    private func navigateToHome() -> FlowContributors {
        print("homeee")
        let homeFlow = HomeFlow()
        Flows.use(
            homeFlow,
            when: .created) { root in
                self.window.rootViewController = root
//                root.modalPresentationStyle = .fullScreen
//                root.modalTransitionStyle = .crossDissolve
                print(root)
            }
        return .one(flowContributor: .contribute(
            withNextPresentable: homeFlow,
            withNextStepper: OneStepper(withSingleStep: AppStep.homeIsRequired)
            )
        )
    }
    private func navigateTest() -> FlowContributors {
//        let vc = BookSearchViewController(viewModel: container.bookSearchViewModel)
//        let vc = BookDetailViewController(viewModel: container.bookDetailViewModel)
//        let vc = ProfileEditViewController(viewModel: container.profileEditViewModel)
        let vc = BookReviewDetailViewController(viewModel: container.bookReviewDetailViewModel)
        self.window.rootViewController = vc
        return .one(flowContributor: .contribute(
            withNextPresentable: vc,
            withNextStepper: OneStepper(withSingleStep: AppStep.testIsRequired)))
    }
}
