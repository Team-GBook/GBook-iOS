import Foundation
import RxSwift

public class WriteReplyUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(commentId: String, comment: String) -> Completable {
        self.repository.writeReply(commentId: commentId, comment: comment)
    }
}
