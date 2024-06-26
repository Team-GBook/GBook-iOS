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
        
        case .profileIsRequired:
            return navigateToProfile()
        case .profileEditRequired:
            return navigateToProfileEdit()
        case .popIsRequird:
            return navigateToPop()
        case .popToRootView:
            return popToRootView()

        case .bookReviewDetailIsRequired(let isbn, let reviewId):
            return navigateToBookReviewDetail(isbn: isbn, reviewId: reviewId)
        case .bookReviewEditIsRequired(let isbn):
            return navigateToReviewEdit(isbn: isbn)
        case .reviewCommentIsRequired(let reviewId):
            return navigateToComment(reviewId: reviewId)
        case .reviewReplyIsRequired(let commentId, let userName, let content, let replyCount):
            return navigateToReply(commentId: commentId, userName: userName, content: content, replyCount: replyCount)
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
            withNextStepper: bookReviewWriteViewContler.viewModel))
    }
    private func navigateToProfile() -> FlowContributors {
        let profileViewController = ProfileViewController(viewModel: container.profileViewModel)
        rootViewController.pushViewController(profileViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: profileViewController,
            withNextStepper: profileViewController.viewModel))
    }
    private func navigateToProfileEdit() -> FlowContributors {
        let profileEditViewController = ProfileEditViewController(viewModel: container.profileEditViewModel)
        rootViewController.pushViewController(profileEditViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: profileEditViewController,
            withNextStepper: profileEditViewController.viewModel))
    }
    private func navigateToPop() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
    private func popToRootView() -> FlowContributors {
        rootViewController.popToRootViewController(animated: true)
        return .none
    }

    private func navigateToBookReviewDetail(isbn: String, reviewId: String) -> FlowContributors {
        let bookReviewDetailViewController = BookReviewDetailViewController(viewModel: container.bookReviewDetailViewModel)
        bookReviewDetailViewController.viewModel.reviewId = reviewId
        bookReviewDetailViewController.viewModel.isbn = isbn
        rootViewController.pushViewController(bookReviewDetailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: bookReviewDetailViewController,
            withNextStepper: bookReviewDetailViewController.viewModel))
    }

    private func navigateToComment(reviewId: String) -> FlowContributors {
        let reviewCommentViewController = ReviewCommentViewController(viewModel: container.reviewCommentViewModel)
        reviewCommentViewController.viewModel.reviewId = reviewId
        rootViewController.pushViewController(reviewCommentViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: reviewCommentViewController,
            withNextStepper: reviewCommentViewController.viewModel))
    }

    private func navigateToReviewEdit(isbn: String) -> FlowContributors {
        let bookReviewEditViewController = BookReviewEditViewController(viewModel: container.bookReviewEditViewModel)
        bookReviewEditViewController.viewModel.isbn = isbn
        rootViewController.pushViewController(bookReviewEditViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: bookReviewEditViewController,
            withNextStepper: bookReviewEditViewController.viewModel
        ))
    }
    private func navigateToReply(commentId: String, userName: String, content: String, replyCount: Int) -> FlowContributors {
        let replyViewController = ReplyViewController(viewModel: container.replyViewModel)
        replyViewController.viewModel.commentId = commentId
        replyViewController.viewModel.content = content
        replyViewController.viewModel.userName = userName
        replyViewController.viewModel.replyCount = replyCount
        rootViewController.pushViewController(replyViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: replyViewController,
            withNextStepper: replyViewController.viewModel)
        )
    }
}
