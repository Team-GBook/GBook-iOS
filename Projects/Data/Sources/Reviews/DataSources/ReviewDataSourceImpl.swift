import Foundation
import AppNetwork
import Domain
import Moya
import RxSwift

public final class ReviewDataSourceImpl: ReviewsDataSourcesInterface {
    private let provider = MoyaProvider<ReviewsAPI>(plugins: [MoyaLoggingPlugin()])
    public static let shard = ReviewDataSourceImpl()

    public func writeReview(isbn: String, request: Domain.ReviewRequest) -> RxSwift.Completable {
        return provider.rx.request(.writeReview(isbn: isbn, request: request))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    public func patchReview(isbn: String, request: Domain.ReviewRequest) -> RxSwift.Completable {
        return provider.rx.request(.patchReview(isbn: isbn, request: request))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    public func deleteReview(isbn: String) -> RxSwift.Completable {
        return provider.rx.request(.deleteReview(isbn: isbn))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    
    public func fetchReview(isbn: String) -> RxSwift.Single<Moya.Response> {
        return provider.rx.request(.fetchReviews(isbn: isbn))
            .filterSuccessfulStatusCodes()
    }
    
    public func fetchReviewDetail(reviewId: String) -> RxSwift.Single<Moya.Response> {
        return provider.rx.request(.fetchDetailReviews(reviewId: reviewId))
            .filterSuccessfulStatusCodes()
    }
    
    
}
