import Foundation
import RxSwift

public class PatchReviewUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String, request: ReviewRequest) -> Completable {
        self.repository.patchReview(isbn: isbn, request: request)
    }
}
