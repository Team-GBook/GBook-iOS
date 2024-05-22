import Foundation
import RxSwift

public class LikeBookUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute(isbn: String) -> Completable {
        self.repository.likeBook(isbn: isbn)
    }
}
