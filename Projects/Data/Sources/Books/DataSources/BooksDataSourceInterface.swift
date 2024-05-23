import Foundation
import Moya
import RxSwift

public protocol BooksDataSourceInterface {
    func searchBooks(keyword: String) -> Single<Response>
    func fetchBestSeller() -> Single<Response>
    func likeBooks(isbn: String) -> Completable
}
