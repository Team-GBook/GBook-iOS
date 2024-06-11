import Foundation
import Moya
import RxSwift

public protocol ReviewsRepositoryInterface {
    func writeReview(isbn: String, request: ReviewRequest) -> Completable
    func patchReview(isbn: String, request: ReviewRequest) -> Completable
    func deleteReview(isbn: String) -> Completable
    func fetchReview(isbn: String) -> Single<BookReviewListEntity>
    func fetchReviewDetail(reviewId: String) -> Single<ReviewDetailEntity>

    func fetchReviewComment(reviewId: String) -> Single<CommentListEntity>
    func writeComment(reviewId: String, comment: String) -> Completable
    func fetchReviewReply(commentId: String) -> Single<ReplyListEntity>
    func writeReply(commentId: String, comment: String) -> Completable

}
