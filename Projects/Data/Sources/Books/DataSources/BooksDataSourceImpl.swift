import Foundation
import Domain
import Moya
import RxSwift
import RxMoya
import AppNetwork

public class BooksDataSourceImpl: BooksDataSourceInterface {
    private let provider = MoyaProvider<BooksAPI>(plugins: [MoyaLoggingPlugin()])
    public static let shard = BooksDataSourceImpl()

    public func searchBooks(keyword: String) -> RxSwift.Single<Moya.Response> {
        return provider.rx.request(.searchBooks(keyword: keyword))
            .filterSuccessfulStatusCodes()
    }
    public func fetchBestSeller() -> RxSwift.Single<Moya.Response> {
        return provider.rx.request(.fetchBestSeller)
            .filterSuccessfulStatusCodes()
    }
    public func likeBooks(isbn: String) -> Completable {
        return provider.rx.request(.likeBook(isbn: isbn))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    public func fetchReview(isbn: String) -> RxSwift.Single<Moya.Response> {
        return provider.rx.request(.fetchReviews(isbn: isbn))
            .filterSuccessfulStatusCodes()
    }

    public func writeReview(isbn: String, request: ReviewWriteRequest) -> Completable {
        return provider.rx.request(.writeReview(isbn: isbn, request: request))
            .filterSuccessfulStatusCodes()
            .asCompletable()
    }
    

}
