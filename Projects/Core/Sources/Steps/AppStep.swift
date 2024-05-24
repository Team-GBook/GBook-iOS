import RxFlow
import UIKit

public enum AppStep: Step {

    case onboardingIsRequired
    case loginIsRequired
    case emailInputIsRequired
    case emailCheckIsRequired(email: String)
    case signupIsRequired(email: String)
    case successSignup
    case homeIsRequired
    case searchIsRequired
    case bookReviewIsRequired(isbn: String)
    case bookReviewWriteIsRequired(isbn: String)

    case testIsRequired
    case error
}
