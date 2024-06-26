import Foundation
import Domain
import RxSwift
import Core

public class BooksRepositoryImpl: BooksRepositoryInterface {

    private let dataSource = BooksDataSourceImpl.shard
    public func searchBooks(keyword: String) -> RxSwift.Single<Domain.BookListEntity> {
        return dataSource.searchBooks(keyword: keyword)
            .map(BookListDTO.self)
            .map { $0.toDomain() }
    }
    public func fetchBestSeller() -> RxSwift.Single<Domain.BookListEntity> {
        return dataSource.fetchBestSeller()
            .map(BookListDTO.self)
            .map { $0.toDomain() } }
    
    public func likeBook(isbn: String) -> RxSwift.Completable {
        return dataSource.likeBooks(isbn: isbn)
    }
    public func fetchDetailBook(isbn: String) -> RxSwift.Single<Domain.BookDetailsEntity> {
        return dataSource.fetchDetail(isbn: isbn)
            .map(BookDetailDTO.self)
            .map { $0.toDomain() }
    }
    public func fetchReview(isbn: String) -> RxSwift.Single<Domain.BookReviewListEntity> {
        return dataSource.fetchReview(isbn: isbn)
            .map(BookReviewListDTO.self)
            .map { $0.toDomain() }
    }
    public func writeReview(isbn: String, request: ReviewRequest) -> Completable {
        return dataSource.writeReview(isbn: isbn, request: request)
    }

}
