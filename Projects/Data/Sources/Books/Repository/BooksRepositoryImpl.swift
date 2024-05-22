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
            .map { $0.toDomain() }    }
    
    public func likeBook(isbn: String) -> RxSwift.Completable {
        return dataSource.likeBooks(isbn: isbn)
    }
}
