import Foundation
import Domain
import Moya
import RxSwift

public protocol BooksDataSourceInterface {
    func searchBooks(keyword: String) -> Single<Response>
    func fetchBestSeller() -> Single<Response>
    func likeBooks(isbn: String) -> Completable
    func fetchReview(isbn: String) -> Single<Response>
    func writeReview(isbn: String, request: ReviewWriteRequest) -> Completable
}
