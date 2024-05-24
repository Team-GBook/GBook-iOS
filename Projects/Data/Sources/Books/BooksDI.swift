import Domain

public struct BooksDI {

    public static let shared = Self.resolve()
    public let bookSearchUseCase: BookSearchUseCase
    public let fetchBestSellerUseCase: FetchBestSellerUseCase
    public let likeBookUseCase: LikeBookUseCase
    public let fetchDetailBookUseCase: FetchDetailBookUseCase
    public let fetchReviewUseCase: FetchReviewUseCase
    public let writeReviewUseCase: WriteReviewUseCase
}

extension BooksDI {
    static func resolve() -> BooksDI {
        let booksRepositoryImpl = BooksRepositoryImpl()
        let searchBooksUseCase = BookSearchUseCase(repository: booksRepositoryImpl)
        let fetchBestSellerUseCase = FetchBestSellerUseCase(repository: booksRepositoryImpl)
        let fetchDetailBookuseCase = FetchDetailBookUseCase(repository: booksRepositoryImpl)
        let likeBookUseCase = LikeBookUseCase(repository: booksRepositoryImpl)
        let fetchReviewUseCase = FetchReviewUseCase(repository: booksRepositoryImpl)
        let writeReviewUseCase = WriteReviewUseCase(repository: booksRepositoryImpl)
        return .init(
            bookSearchUseCase: searchBooksUseCase,
            fetchBestSellerUseCase: fetchBestSellerUseCase,
            likeBookUseCase: likeBookUseCase,
            fetchDetailBookUseCase: fetchDetailBookuseCase,
            fetchReviewUseCase: fetchReviewUseCase
            writeReviewUseCase: writeReviewUseCase
        )
    }
}
