import Foundation
import RxSwift

public class SignupUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(
        email: String,
        password: String,
        nickName: String,
        genre: String
    ) -> Completable {
        self.repository.signup(
            email: email,
            password: password,
            nickName: nickName,
            genre: genre
        )
    }
}
