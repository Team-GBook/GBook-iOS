import Foundation
import RxSwift

public class EditUserProfileUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(
        nickName: String,
        genre: String
    ) -> Completable {
        self.repository.editUserProfile(
            nickName: nickName,
            genre: genre
        )
    }
}
