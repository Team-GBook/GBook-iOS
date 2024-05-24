import RxFlow
import Foundation
import RxSwift
import Core
import Presentation

public class HomeFlow: Flow {


    private let container = FlowDI.shared
    private let rootViewController: BaseNavigationController

    public init() {
        self.rootViewController = BaseNavigationController()
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
        case .bookReviewIsRequired(let isbn):
            return navigateToBookDetail(isbn: isbn)
        case .bookReviewWriteIsRequired(let isbn):
            return navigateToBookReportWrite(isbn: isbn)
        default:
            return .none
        }
    }
    private func navigateToHome() -> FlowContributors {
        let homeViewController = HomeViewController(viewModel: container.homeViewModel)
//        self.rootViewController.navigationBar.isHidden = true
        self.rootViewController.setViewControllers([homeViewController], animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper: homeViewController.viewModel
        ))
    }
    private func navigateToSearch() -> FlowContributors {
        let searchViewController = BookSearchViewController(viewModel: container.bookSearchViewModel)
        self.rootViewController.pushViewController(searchViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: searchViewController,
            withNextStepper: searchViewController.viewModel
        ))
    }
    private func navigateToBookDetail(isbn: String) -> FlowContributors {
        let bookDetailViewController = BookDetailViewController(viewModel: container.bookDetailViewModel)
        bookDetailViewController.viewModel.isbn = isbn
        self.rootViewController.pushViewController(bookDetailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: bookDetailViewController,
            withNextStepper: bookDetailViewController.viewModel)
        )
    }
    private func navigateToBookReportWrite(
        isbn: String
    ) -> FlowContributors {
        let bookReviewWriteViewContler = BookReviewWriteViewContler(
            viewModel: container.bookReviewWriteViewModel
        )
        bookReviewWriteViewContler.viewModel.isbn = isbn
        print("12ij41j")
        rootViewController.pushViewController(bookReviewWriteViewContler, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: bookReviewWriteViewContler,
            withNextStepper: OneStepper(withSingleStep: AppStep.error)))
    }
}
