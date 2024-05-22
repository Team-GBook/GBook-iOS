import RxFlow
import RxSwift
import Core
import Presentation

public class HomeFlow: Flow {


    private let container = FlowDI.shared
    private let rootViewController: HomeViewController

    public init(rootViewController: HomeViewController) {
        self.rootViewController = HomeViewController(viewModel: container.homeViewModel)
    }

    public var root: Presentable {
        return rootViewController
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? AppStep else { return .none }
        switch step {
        case .homeIsRequired:
            return navigateToHome()
        case .searchIsRequired:
            return navigateToSearch()
        default:
            return .none
        }
    }
    private func navigateToHome() -> FlowContributors {
        self.rootViewController.navigationController?.setViewControllers([rootViewController], animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }
    private func navigateToSearch() -> FlowContributors {
        let searchViewController = BookSearchViewController(viewModel: container.bookSearchViewModel)
        self.rootViewController.navigationController?.pushViewController(searchViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: searchViewController,
            withNextStepper: searchViewController.viewModel
        ))
    }
}
