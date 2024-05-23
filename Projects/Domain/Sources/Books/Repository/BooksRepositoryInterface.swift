import Foundation
import RxSwift

public protocol BooksRepositoryInterface {
    func searchBooks(keyword: String) -> Single<BookListEntity>
    func fetchBestSeller() -> Single<BookListEntity>
    func likeBook(isbn: String) -> Completable
    func fetchReview(isbn: String) -> Single<BookReviewListEntity>
}
