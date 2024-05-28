import Foundation
import RxSwift

public class FetchDetailReviewUseCase {

    private let repository: ReviewsRepositoryInterface

    public init(repository: ReviewsRepositoryInterface) {
        self.repository = repository
    }

    public func excute(reviewId: String) -> Single<ReviewDetailEntity> {
        self.repository.fetchReviewDetail(reviewId: reviewId)
    }
}
