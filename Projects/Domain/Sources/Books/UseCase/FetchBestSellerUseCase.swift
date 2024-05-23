import Foundation
import RxSwift

public class FetchBestSellerUseCase {

    private let repository: BooksRepositoryInterface

    public init(repository: BooksRepositoryInterface) {
        self.repository = repository
    }

    public func excute() -> Single<BookListEntity>{
        self.repository.fetchBestSeller()
    
    }
}
