import Domain

public struct AuthDI {

    public static let shared = Self.resolve()
    public let loginUseCase: LoginUseCase
    public let sendEmailUseCase: SendEmailUseCase
    public let emailCheckUseCase: EmailCheckUseCase
    public let signupUseCase: SignupUseCase
}

extension AuthDI {

    static func resolve() -> AuthDI {
        let authRepositoryImpl = AuthRepositoryImpl()
        let loginUseCase = LoginUseCase(repository: authRepositoryImpl)
        let sendEmailUseCase = SendEmailUseCase(repository: authRepositoryImpl)
        let emailCheckUseCase = EmailCheckUseCase(repository: authRepositoryImpl)
        let signupUseCase = SignupUseCase(repository: authRepositoryImpl)

        return .init(
            loginUseCase: loginUseCase,
            sendEmailUseCase: sendEmailUseCase,
            emailCheckUseCase: emailCheckUseCase,
            signupUseCase: signupUseCase
        )
    }
}
