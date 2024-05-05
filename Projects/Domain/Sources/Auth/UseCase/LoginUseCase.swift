import Foundation
import RxSwift

public class LoginUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(email: String, password: String) -> Completable{
        self.repository.login(email: email, password: password)
    
    }
}
