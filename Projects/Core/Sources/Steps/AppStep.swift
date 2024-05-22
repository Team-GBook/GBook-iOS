import RxFlow

public enum AppStep: Step {

    case onboardingIsRequired
    case loginIsRequired
    case emailInputIsRequired
    case emailCheckIsRequired(email: String)
    case signupIsRequired(email: String)
    case successSignup
    case homeIsRequired
    case searchIsRequired

    case testIsRequired
    case error
}
