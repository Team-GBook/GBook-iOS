import Foundation
import RxSwift

public class FetchReviewUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String) -> Single<BookReviewListEntity> {
        self.repository.fetchReview(isbn: isbn)
    }
}
