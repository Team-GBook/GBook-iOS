import Foundation
import RxSwift

public class FetchDetailBookUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String) -> Single<BookDetailsEntity> {
        self.repository.fetchDetailBook(isbn: isbn)
    }
}
