import Foundation
import RxSwift

public class FetchReviewReplyUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(commentId: String) -> Single<ReplyListEntity> {
        self.repository.fetchReviewReply(commentId: commentId)
    }
}
