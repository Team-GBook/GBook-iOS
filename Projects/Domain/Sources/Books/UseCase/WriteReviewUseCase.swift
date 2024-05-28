import Foundation
import RxSwift

public class WriteReviewUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String, request: ReviewRequest) -> Completable {
        self.repository.writeReview(isbn: isbn, request: request)
    }
}
