import Foundation
import RxSwift

public class WriteCommentUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(reviewId: String, comment: String) -> Completable {
        self.repository.writeComment(reviewId: reviewId, comment: comment)
    }
}
