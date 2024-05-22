import Foundation
import RxSwift

public class EmailCheckUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(email: String, code: Int) -> Completable{
        self.repository.emailCheck(email: email, code: code)
    }
}
