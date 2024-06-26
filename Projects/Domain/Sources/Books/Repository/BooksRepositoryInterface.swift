import Foundation
import RxSwift

public protocol BooksRepositoryInterface {
    func searchBooks(keyword: String) -> Single<BookListEntity>
    func fetchBestSeller() -> Single<BookListEntity>
    func likeBook(isbn: String) -> Completable
    func fetchDetailBook(isbn: String) -> Single<BookDetailsEntity>
    func fetchReview(isbn: String) -> Single<BookReviewListEntity>
    func writeReview(isbn: String, request: ReviewRequest) -> Completable
}
