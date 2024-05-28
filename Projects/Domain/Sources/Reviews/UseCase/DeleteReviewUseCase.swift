import Foundation
import RxSwift

public class DeleteReviewUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String) -> Completable {
        self.repository.deleteReview(isbn: isbn)
    }
}
