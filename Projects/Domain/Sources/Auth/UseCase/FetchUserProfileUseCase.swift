import Foundation
import RxSwift

public class FetchUserProfileUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute() -> Single<UserEntity> {
        self.repository.fetchUserProfile()
    }
}
