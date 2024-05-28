import Foundation
import AppNetwork
import Domain
import Moya
import RxSwift

public final class ReviewsRepositoryImpl: ReviewsRepositoryInterface {

    let dataSource = ReviewDataSourceImpl.shard

    public func writeReview(isbn: String, request: Domain.ReviewRequest) -> RxSwift.Completable {
        return dataSource.writeReview(isbn: isbn, request: request)
    }
    
    public func patchReview(isbn: String, request: Domain.ReviewRequest) -> RxSwift.Completable {
        return dataSource.patchReview(isbn: isbn, request: request)
    }
    
    public func deleteReview(isbn: String) -> RxSwift.Completable {
        return dataSource.deleteReview(isbn: isbn)
    }
    
    public func fetchReview(isbn: String) -> RxSwift.Single<Domain.BookReviewListEntity> {
        return dataSource.fetchReview(isbn: isbn)
            .map(ReviewListDTO.self)
            .map { $0.toDomain() }
    }
    
    public func fetchReviewDetail(reviewId: String) -> RxSwift.Single<Domain.ReviewDetailEntity> {
        return dataSource.fetchReviewDetail(reviewId: reviewId)
            .map(ReviewDetailDTO.self)
            .map { $0.toDomain() }
    }
    

}
