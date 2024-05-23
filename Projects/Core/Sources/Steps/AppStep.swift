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
    case bookReviewIsRequired(bookImage: UIImage, bookTitle: String, author: String, publisher: String)
    case bookReviewWriteIsRequired(bookImage: URL, bookTitle: String, author: String, publisher: String)

    case testIsRequired
    case error
}
