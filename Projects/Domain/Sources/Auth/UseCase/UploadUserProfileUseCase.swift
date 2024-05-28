import Foundation
import RxSwift

public class UploadUserProfileUseCase {

    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func excute(
        imageData: Data
    ) -> Completable {
        self.repository.uploadProfile(imageData: imageData)
    }
}
