import RxFlow
import UIKit

public enum AppStep: Step {

    case onboardingIsRequired
    case loginIsRequired
    case emailInputIsRequired
    case emailCheckIsRequired(email: String)
    case signupIsRequired(email: String)
    case profileIsRequired
    case profileEditRequired
    case successSignup
    case homeIsRequired
    case searchIsRequired
    case bookReviewIsRequired(isbn: String)
    case bookReviewWriteIsRequired(isbn: String)
    case bookReviewDetailIsRequired(isbn: String, reviewId: String)
    case bookReviewEditIsRequired(isbn: String)
    case bookReviewDeleteIsRequired(isbn: String)

    case reviewCommentIsRequired(reviewId: String)
    case reviewReplyIsRequired(commentId: String, userName: String, content: String, replyCount: Int)
    case popIsRequird
    case popToRootView

    case testIsRequired
    case error
}
