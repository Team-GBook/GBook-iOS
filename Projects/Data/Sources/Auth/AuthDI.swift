import Domain

public struct AuthDI {

    public static let shared = Self.resolve()
    public let loginUseCase: LoginUseCase
    public let sendEmailUseCase: SendEmailUseCase
    public let emailCheckUseCase: EmailCheckUseCase
    public let signupUseCase: SignupUseCase
    public let fetchUserProfileUseCase: FetchUserProfileUseCase
    public let editUserProfileUseCase: EditUserProfileUseCase
    public let uploadUserProfileUseCase: UploadUserProfileUseCase
}

extension AuthDI {

    static func resolve() -> AuthDI {
        let authRepositoryImpl = AuthRepositoryImpl()
        let loginUseCase = LoginUseCase(repository: authRepositoryImpl)
        let sendEmailUseCase = SendEmailUseCase(repository: authRepositoryImpl)
        let emailCheckUseCase = EmailCheckUseCase(repository: authRepositoryImpl)
        let signupUseCase = SignupUseCase(repository: authRepositoryImpl)
        let fetchUserProfileUseCase = FetchUserProfileUseCase(repository: authRepositoryImpl)
        let editUserProfileUseCase = EditUserProfileUseCase(repository: authRepositoryImpl)
        let uploadUserProfileUseCase = UploadUserProfileUseCase(repository: authRepositoryImpl)

        return .init(
            loginUseCase: loginUseCase,
            sendEmailUseCase: sendEmailUseCase,
            emailCheckUseCase: emailCheckUseCase,
            signupUseCase: signupUseCase,
            fetchUserProfileUseCase: fetchUserProfileUseCase,
            editUserProfileUseCase: editUserProfileUseCase,
            uploadUserProfileUseCase: uploadUserProfileUseCase
        )
    }
}
