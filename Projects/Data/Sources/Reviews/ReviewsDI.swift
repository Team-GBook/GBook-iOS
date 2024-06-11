import Domain

public struct ReviewsDI {
    public static let shared = Self.resolve()

    public let patchReviewUseCase: PatchReviewUseCase
    public let deleteReviewUseCase: DeleteReviewUseCase
    public let fetchDetailUseCase: FetchDetailReviewUseCase

    public let fetchReviewCommentUseCase: FetchReviewCommentUseCase
    public let fetchReviewReplyUseCase: FetchReviewReplyUseCase
    public let writeCommentUseCase: WriteCommentUseCase
    public let writeReplyUseCase: WriteReplyUseCase
}

extension ReviewsDI {
    static func resolve() -> ReviewsDI {
        let reviewsRepositoryImpl = ReviewsRepositoryImpl()

        let patchReviewUseCase = PatchReviewUseCase(repository: reviewsRepositoryImpl)
        let deleteReviewUseCase = DeleteReviewUseCase(repository: reviewsRepositoryImpl)
        let fetchDetailUseCase = FetchDetailReviewUseCase(repository: reviewsRepositoryImpl)

        let fetchReviewCommentUseCase = FetchReviewCommentUseCase(repository: reviewsRepositoryImpl)
        let fetchReviewReplyUseCase = FetchReviewReplyUseCase(repository: reviewsRepositoryImpl)
        let writeCommentUseCase = WriteCommentUseCase(repository: reviewsRepositoryImpl)
        let writeReplyUseCase = WriteReplyUseCase(repository: reviewsRepositoryImpl)
        return .init(
            patchReviewUseCase: patchReviewUseCase, 
            deleteReviewUseCase: deleteReviewUseCase,
            fetchDetailUseCase: fetchDetailUseCase,
            fetchReviewCommentUseCase: fetchReviewCommentUseCase,
            fetchReviewReplyUseCase: fetchReviewReplyUseCase,
            writeCommentUseCase: writeCommentUseCase,
            writeReplyUseCase: writeReplyUseCase
        )
    }
}
