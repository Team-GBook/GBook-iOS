import Domain

public struct BooksDI {

    public static let shared = Self.resolve()
    public let bookSearchUseCase: BookSearchUseCase
    public let fetchBestSellerUseCase: FetchBestSellerUseCase
    public let likeBookUseCase: LikeBookUseCase
}

extension BooksDI {
    static func resolve() -> BooksDI {
        let booksRepositoryImpl = BooksRepositoryImpl()
        let searchBooksUseCase = BookSearchUseCase(repository: booksRepositoryImpl)
        let fetchBestSellerUseCase = FetchBestSellerUseCase(repository: booksRepositoryImpl)
        let likeBookUseCase = LikeBookUseCase(repository: booksRepositoryImpl)
        return .init(
            bookSearchUseCase: searchBooksUseCase,
            fetchBestSellerUseCase: fetchBestSellerUseCase,
            likeBookUseCase: likeBookUseCase
        )
    }
}