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
    case bookReviewDetailIsRequired(reviewId: String)
    case bookReviewEditIsRequired(isbn: String)
    case bookReviewDeleteIsRequired(isbn: String)

    case popIsRequird

    case testIsRequired
    case error
}
