import Foundation
import RxSwift

public class SendEmailUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(email: String) -> Completable {
        self.repository.sendEmail(email: email)
    }
}
