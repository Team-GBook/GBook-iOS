import Domain

public struct AuthDI {

    public static let shared = Self.resolve()
    public let loginUseCase: LoginUseCase

}

extension AuthDI {

    static func resolve() -> AuthDI {
        let authRepositoryImpl = AuthRepositoryImpl()
        let loginUseCase = LoginUseCase(repository: authRepositoryImpl)
        
        return .init(
            loginUseCase: loginUseCase
        )
    }
}
