import Foundation
import RxSwift

public class FetchReviewCommentUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(reviewId: String) -> Single<CommentListEntity> {
        self.repository.fetchReviewComment(reviewId: reviewId)
    }
}
