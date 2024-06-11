import Foundation
import Domain
import Moya
import RxSwift

public protocol ReviewsDataSourcesInterface {
    func writeReview(isbn: String, request: ReviewRequest) -> Completable
    func patchReview(isbn: String, request: ReviewRequest) -> Completable
    func deleteReview(isbn: String) -> Completable
    func fetchReview(isbn: String) -> Single<Response>
    func fetchReviewDetail(reviewId: String) -> Single<Response>

    func fetchReviewComment(reviewId: String) -> Single<Response>
    func writeComment(reviewId: String, comment: String) -> Completable
    func fetchReviewReply(commentId: String) -> Single<Response>
    func writeReply(commentId: String, comment: String) -> Completable
}
