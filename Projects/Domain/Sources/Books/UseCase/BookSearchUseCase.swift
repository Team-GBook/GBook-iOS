import Foundation
import RxSwift

public class BookSearchUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute(keyword: String) -> Single<BookListEntity>{
        self.repository.searchBooks(keyword: keyword)
    
    }
}
