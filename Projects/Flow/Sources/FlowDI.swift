import Foundation
import Presentation
import Data

public struct FlowDI {

    public static let shared = resolve()

    public let onboardingViewModel: OnboardingViewModel
    public let loginViewModel: LoginViewModel
    public let emailInputViewModel: EmailInputViewModel
    public let emailCheckViewModel: EmailCheckViewModel
    public let signUpViewModel: SignupViewModel
    public let profileViewModel: ProfileViewModel
    public let profileEditViewModel: ProfileEditViewModel

    //Books
    public let homeViewModel: HomeViewModel
    public let bookSearchViewModel: BookSearchViewModel
    public let bookDetailViewModel: BookDetailViewModel

    //Reviews
    public let bookReviewWriteViewModel: BookReviewWriteViewModel
    public let bookReviewDetailViewModel: BookReviewDetailViewModel

}

extension FlowDI {
    private static func resolve() -> FlowDI {
        let authDI = AuthDI.shared
        let booksDI = BooksDI.shared
        let reviewsDI = ReviewsDI.shared

        let onboardingViewModel = OnboardingViewModel()
        let loginViewModel = LoginViewModel(loginUseCase: authDI.loginUseCase)
        let emailInputViewModel = EmailInputViewModel(sendEmailUseCase: authDI.sendEmailUseCase)
        let emailCheckViewModel = EmailCheckViewModel(emailCheckUseCase: authDI.emailCheckUseCase)
        let signupViewModel = SignupViewModel(signupUseCase: authDI.signupUseCase)
        let profileViewModel = ProfileViewModel(fetchUserProfileUseCase: authDI.fetchUserProfileUseCase)
        let profileEditViewModel = ProfileEditViewModel(
            uploadUserProfileUseCase: authDI.uploadUserProfileUseCase,
            editUserProfileUseCase: authDI.editUserProfileUseCase
        )

        let booksSearchViewModel = BookSearchViewModel(
            searchBookUseCase: booksDI.bookSearchUseCase,
            likeBookUseCase: booksDI.likeBookUseCase
        )
        let bookDetailViewModel = BookDetailViewModel(
            fetchDetailBookUseCase: booksDI.fetchDetailBookUseCase,
            fetchReviewUseCase: booksDI.fetchReviewUseCase
        )
        let homeViewModel = HomeViewModel(
            fetchBestSellerUseCase: booksDI.fetchBestSellerUseCase,
            likeBookUseCase: booksDI.likeBookUseCase
        )
        let bookReviewWriteViewModel = BookReviewWriteViewModel(
            fetchDetailBookUseCase: booksDI.fetchDetailBookUseCase,
            writeReviewUseCase: booksDI.writeReviewUseCase
        )

        let bookReviewDetailViewModel = BookReviewDetailViewModel(
            fetchDetailBookUseCase: reviewsDI.fetchDetailUseCase,
            editReviewUseCase: reviewsDI.patchReviewUseCase,
            deleteReviewUseCase: reviewsDI.deleteReviewUseCase
        )
        return .init(
            onboardingViewModel: onboardingViewModel,
            loginViewModel: loginViewModel,
            emailInputViewModel: emailInputViewModel,
            emailCheckViewModel: emailCheckViewModel,
            signUpViewModel: signupViewModel,
            profileViewModel: profileViewModel,
            profileEditViewModel: profileEditViewModel,
            //books
            homeViewModel: homeViewModel,
            bookSearchViewModel: booksSearchViewModel, 
            bookDetailViewModel: bookDetailViewModel,
            bookReviewWriteViewModel: bookReviewWriteViewModel,
            bookReviewDetailViewModel: bookReviewDetailViewModel
        )
    }
}
